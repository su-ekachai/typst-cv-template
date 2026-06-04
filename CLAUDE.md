# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
make setup          # First-time: copy data/*.example.toml → data/*.toml
make all            # Build resume + cover letter PDFs
make resume         # Build resume only → output/resume.pdf
make cover_letter   # Build cover letter only → output/cover_letter.pdf
make watch-resume   # Live rebuild on file changes
make clean          # Remove generated PDFs
```

Underlying command: `typst compile --root . --font-path assets/fonts src/resume.typ output/resume.pdf`

## Architecture

This is a data-driven Typst CV generator. Content and presentation are separated:

```
data/*.toml  →  src/*.typ (templates)  →  output/*.pdf
   (content)       (layout logic)           (result)
```

- **`data/*.toml`** — User content (gitignored, personal). Each file maps to a CV section.
- **`data/*.example.toml`** — Committed examples with fake data. CI compiles against these.
- **`src/resume.typ`** — Template that reads TOML via `toml()` and loops over entries using `#for`.
- **`src/cover_letter.typ`** — Same pattern. Signature is conditional via `use-signature` flag in TOML.
- **`templates/lib.typ`** — template library (Modern CV port). Provides `resume-entry()`, `resume-item()`, `resume-skill-item()`, `coverletter()`, etc.
- **`templates/lang.toml`** — internationalization (i18n) strings for 10 languages.

## Key Patterns

- Typst's `toml()` returns a dictionary. `[[entry]]` arrays are accessed as `.entry`.
- Optional TOML fields use `.at("key", default: value)` to avoid compile errors.
- `resume-item()` expects Typst content: `entry.bullets.map(b => [- #b]).join()`
- Skills use `strong = [...]` (bold) and `items = [...]` (normal) arrays in TOML.
- The `author` dict passed to `resume.with()` must have: `firstname`, `lastname`, `positions`. Other fields (`email`, `phone`, `github`, `linkedin`, `homepage`) are optional — template checks with `"key" in author`.

## Data Privacy

- `data/*.toml` and `assets/images/signature.png` are gitignored (personal data).
- Only `data/*.example.toml` files are committed to the repo.
- CI copies examples before compiling. Never commit real personal data.
