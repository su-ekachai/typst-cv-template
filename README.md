# Typst CV Template

[![Build Status](https://github.com/su-ekachai/typst-cv-template/actions/workflows/build.yml/badge.svg)](https://github.com/su-ekachai/typst-cv-template/actions/workflows/build.yml)
[![Typst](https://img.shields.io/badge/Made%20with-Typst-239DAD?logo=typst&logoColor=white)](https://typst.app/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A data-driven Resume and Cover Letter template built with [Typst](https://typst.app). Edit simple TOML files, run one command, get a professional PDF.

Based on the [Modern CV](https://github.com/DeveloperPaul123/modern-cv) template (port of [Awesome-CV](https://github.com/posquit0/Awesome-CV)).

## Two ways to use this repo

- **Use it as a template (most people):** run `make setup`, edit the files in `data/`, then `make resume`. Your real data stays on your machine — only the template ships.
- **Maintain or contribute:** edit `src/` + `templates/`, and keep personal data out of commits. `make setup` installs a pre-commit hook that blocks personal data automatically; run `make verify` before pushing.

Either way, your private content (`data/*.toml`, `assets/images/`, `local/`) is gitignored and never reaches GitHub — see [Privacy & Sharing](#privacy--sharing).

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/su-ekachai/typst-cv-template.git my-cv
cd my-cv

# 2. Copy example data files + install the privacy pre-commit hook
make setup

# 3. Edit the TOML files in data/ with your information
# (see the "Data Files" section)

# 4. Build your PDF
make resume
make cover_letter
```

## Prerequisites

**Install Typst CLI:**

```bash
# macOS
brew install typst

# Windows
winget install --id Typst.Typst

# Linux — see https://github.com/typst/typst#installation
```

## Project Structure

```
.
├── data/                          # Your CV content (TOML files)
│   ├── README.md                  # Explains public examples vs. private data
│   ├── *.example.toml             # PUBLIC templates (committed, fake data)
│   └── *.toml                     # YOUR data (gitignored; created by `make setup`)
├── src/                           # Typst templates (don't edit these)
│   ├── resume.typ
│   └── cover_letter.typ
├── templates/                     # Template library (lib.typ, lang.toml)
├── assets/
│   ├── fonts/                     # Bundled fonts + licenses (committed)
│   └── images/                    # Signature etc. (gitignored; .gitkeep tracked)
├── .githooks/pre-commit           # Privacy guard (installed by `make setup`)
├── output/                        # Generated PDFs (gitignored)
├── Makefile                       # Build commands
└── .github/workflows/build.yml    # CI/CD (+ privacy guard)
```

## Data Files

After `make setup`, edit the files in `data/` with your information. No Typst knowledge needed — plain TOML.

### `data/profile.toml` — Your identity

```toml
firstname = "John"
lastname = "Doe"
email = "john.doe@example.com"
phone = "(+1) 555-123-4567"
github = "johndoe"
linkedin = "johndoe"
homepage = "https://johndoe.dev"   # optional; leave "" to omit
positions = ["Senior Software Engineer"]
summary = "One short paragraph (3-4 lines) shown at the top. Leave \"\" to hide."
```

Empty optional contact fields (e.g. `homepage = ""`) are skipped automatically, so the contact line never shows stray separators.

### `data/experience.toml` — Work history

```toml
[[entry]]
title = "Senior Software Engineer"
company = "Tech Corp"
location = "San Francisco, CA"
date = "2021 - Present"
link = "https://company.com"          # optional: makes title clickable
bullets = [
  "Led migration to microservices, reducing deployment time by 70%",
  "Designed real-time pipeline processing 5M events/day",
]
```

### `data/skills.toml` — Skills by category

```toml
[[category]]
name = "Programming Languages"
strong = ["Python", "TypeScript"]      # displayed in bold
items = ["Go", "Rust", "Java", "SQL"]  # displayed normally
```

### `data/education.toml` — Education

```toml
[[entry]]
title = "University of Technology"
location = "City, State"
date = "2012 - 2016"
degree = "B.S. in Computer Science"
bullets = ["Graduated Magna Cum Laude"]
```

### `data/projects.toml` — Projects

```toml
[[entry]]
title = "My Cool Project"
github = "username/repo"    # creates a clickable GitHub link
date = "2022 - Present"
role = "Creator/Maintainer"
bullets = ["Built a thing that does stuff"]
```

### `data/cover_letter.toml` — Cover letter

```toml
[company]
target = "Hiring Manager"
name = "Acme Corp"
street-address = "123 Main St"
city = "San Francisco, CA 94105"

[letter]
job-position = "Senior Engineer"
addressee = "Hiring Manager"
use-signature = false           # set true if you add signature.png
paragraphs = [
  "First paragraph...",
  "Second paragraph...",
  "Third paragraph...",
]
```

### Signature (Optional)

Place your signature image at `assets/images/signature.png` and set `use-signature = true` in your cover letter data.

## Privacy & Sharing

This repo is safe to publish: your **content** stays local, only the **system** is shared. Four layers keep personal data out of git:

1. **`.gitignore`** excludes your real data — `data/**/*.toml` (at any depth), everything in `assets/images/` (signature/scans), and all of `local/`. Only `data/*.example.toml` (fake data), `assets/images/.gitkeep`, templates, and docs are tracked.
2. **Pre-commit hook** (`.githooks/pre-commit`, installed by `make setup`) automatically **refuses any commit** that stages personal data, so a stray `git add -A` can't leak it. It travels with the repo via `core.hooksPath`; existing clones arm it with `make hooks`.
3. **`make check-clean`** / **`make verify`** — a manual guard you can run anytime (`verify` also builds both PDFs, mirroring CI). A good pre-push habit.
4. **CI privacy guard** — the GitHub Actions build fails if any personal data is ever tracked, and it compiles from the examples so it never needs your real data.

Keep working drafts (notes, alternate versions, metrics) in `local/` to keep them out of git. Tip: stage files explicitly (e.g. `git add src/ templates/ README.md`) rather than `git add -A`.

## Build Commands

```bash
make setup        # Copy example files + install privacy hook (first-time only)
make all          # Build resume + cover letter
make resume       # Build resume → output/resume.pdf
make cover_letter # Build cover letter only
make watch-resume # Auto-rebuild on changes
make watch-cover  # Auto-rebuild cover letter on changes
make verify       # Privacy guard + build both (run before pushing)
make check-clean  # Fail if personal data is staged for commit (privacy guard)
make hooks        # Install the privacy pre-commit hook (existing clones)
make clean        # Remove generated PDFs
make help         # Show all commands
```

## Customization

### Styling

Edit the style parameters in `src/resume.typ`:

```typst
#show: resume.with(
  accent-color: "#0077B5",    // Accent color for headers/name
  colored-headers: true,       // Color section headers
  language: "en",              // Language (en, de, fr, zh, th, etc.)
  paper-size: "us-letter",     // or "a4"
  show-footer: false,          // Page footer with name/date
  show-contact-icons: true,    // true = FontAwesome contact icons (bundled in assets/fonts/); false = plain-text URLs
)
```

### Fonts & contact icons

Fonts are **bundled in `assets/fonts/`** (all under the SIL Open Font License, redistributable) and the build points Typst at them via `--font-path assets/fonts` (already wired into the `Makefile` and CI):

- **Source Sans 3** — the body font. Bundling it makes layout **deterministic across machines**: without it, Typst falls back to a taller font and content can overflow (e.g., a 1-page resume spilling onto page 2). With it bundled, everyone gets identical line breaks and page fit.
- **Font Awesome 7 Free** — contact icons (phone/email/GitHub/LinkedIn). Icon *and* text/link are both emitted, so contacts stay parseable by Applicant Tracking Systems (ATS). Set `show-contact-icons: false` for plain-text URLs.

No system font installation needed. (The name still uses **Roboto** as the header font; if it isn't installed it falls back gracefully — it's one line and doesn't affect layout.)

### Multi-language Support

Set `language` to any of: `en`, `de`, `gr`, `pt`, `sp`, `fr`, `ru`, `zh`, `it`, `th`.

## CI/CD

GitHub Actions automatically compiles your PDFs on every push. Download from the Actions tab > latest run > Artifacts.

## Editor Setup

**VS Code:** Install [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) for live preview (`Cmd+K V`).

## License

MIT License. See [LICENSE](LICENSE).

Based on [Modern CV](https://github.com/DeveloperPaul123/modern-cv) by Paul Tsouchlos.
