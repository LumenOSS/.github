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

# Everything a change must pass.
check:
    just --fmt --check --unstable
    nixfmt --check flake.nix
    markdownlint-cli2 "**/*.md"
    lychee "**/*.md"
    statix check .
    deadnix --fail .
