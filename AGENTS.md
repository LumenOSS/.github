# AGENTS.md — agent operating guide

This is the LumenOSS organisation's `.github` repository. `profile/README.md`
is the public organisation page; `assets/` holds the brand (see
`assets/README.md`).

- Everything runs in the nix dev shell: `nix develop --command just
  <recipe>`. `just fmt` formats, `just check` verifies; tool rules live in
  their config files at the root.
- The SVGs are the source of truth. After changing the icon, run `just icon`;
  `just check` fails if the PNG is stale.
- Images in the profile README use absolute `raw.githubusercontent.com`
  URLs, because relative paths do not resolve on the organisation page.
- Public repository: roles, never people; no deployment identifiers.
- Jujutsu, colocated with git: `jj describe` then `jj new`. Commits are
  Angular-style: `type(scope): subject`, imperative, lowercase, under 72
  characters, with a body saying why.
