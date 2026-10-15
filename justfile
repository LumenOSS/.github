# Every task is a recipe here, run inside the nix shell:
#
#   nix develop --command just <recipe>

set shell := ["bash", "-euo", "pipefail", "-c"]

# List the recipes.
default:
    @just --list

# Format everything in place.
fmt:
    just --fmt --unstable
    markdownlint-cli2 --fix "**/*.md"
    nixfmt flake.nix

# Render the avatar PNG from its SVG source. GitHub needs a raster image
# for an organisation avatar; the SVG is the source of truth.
icon:
    resvg -w 1024 -h 1024 assets/lumenoss-icon.svg assets/lumenoss-icon.png

# Fail if the avatar PNG is not the render of the current SVG.
icon-check:
    #!/usr/bin/env bash
    set -euo pipefail
    tmp="$(mktemp --suffix .png)"
    trap 'rm -f "$tmp"' EXIT
    resvg -w 1024 -h 1024 assets/lumenoss-icon.svg "$tmp"
    cmp -s "$tmp" assets/lumenoss-icon.png || { echo "run: just icon"; exit 1; }

# Everything a change must pass.
check: icon-check
    just --fmt --check --unstable
    nixfmt --check flake.nix
    markdownlint-cli2 "**/*.md"
    lychee "**/*.md"
    statix check .
    deadnix --fail .
