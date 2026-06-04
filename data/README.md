# Data files

Your CV content lives here as plain TOML — one file per section. There are two kinds:

- **`*.example.toml`** — committed **PUBLIC** templates with fake data. Safe to push.
- **`*.toml`** (e.g. `profile.toml`) — **YOUR real data. Gitignored and PRIVATE — never committed.**

Run `make setup` to copy each `*.example.toml` → `*.toml`, then edit the `*.toml` files with
your information. `make setup` also installs a pre-commit hook that refuses to commit any real
`*.toml`, so your personal data can't reach GitHub even by accident. See the repo README →
"Privacy & Sharing" for details.
