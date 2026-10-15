{
  description = "LumenOSS organisation profile and brand assets";

  # nixpkgs-unstable, pinned by flake.lock, so every machine resolves the
  # same tools. Bump deliberately with `nix flake update`.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        # Formatting and linting are the tools' job; each tool's rules live
        # in its config file at the repository root.
        default = pkgs.mkShell {
          packages = with pkgs; [
            just
            # Markdown: lint and fix (.markdownlint-cli2.yaml), editor
            # server, offline link check (lychee.toml).
            markdownlint-cli2
            marksman
            lychee
            # SVG to PNG for the avatar and previews.
            resvg
            # Nix: format, lint, editor server.
            nixfmt
            statix
            deadnix
            nil
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
