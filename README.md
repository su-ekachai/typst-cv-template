# Typst CV Template

[![Build Status](https://github.com/eakkz/eakkz-cv/actions/workflows/build.yml/badge.svg)](https://github.com/eakkz/eakkz-cv/actions/workflows/build.yml)
[![Typst](https://img.shields.io/badge/Made%20with-Typst-239DAD?logo=typst&logoColor=white)](https://typst.app/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A data-driven Resume and Cover Letter template built with [Typst](https://typst.app). Edit simple TOML files, run one command, get a professional PDF.

Based on the [Modern CV](https://github.com/DeveloperPaul123/modern-cv) template (port of [Awesome-CV](https://github.com/posquit0/Awesome-CV)).

## Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/eakkz/eakkz-cv.git my-cv
cd my-cv

# 2. Copy example data files
make setup

# 3. Edit the TOML files in data/ with your information
# (see "Data Files" section below)

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
│   ├── profile.example.toml       # Name, contact info, links
│   ├── experience.example.toml    # Work history
│   ├── projects.example.toml      # Personal/open-source projects
│   ├── skills.example.toml        # Categorized skills
│   ├── education.example.toml     # Education
│   └── cover_letter.example.toml  # Per-application cover letter
├── src/                           # Typst templates (don't edit these)
│   ├── resume.typ
│   └── cover_letter.typ
├── templates/                     # Template library
│   ├── lib.typ
│   └── lang.toml
├── assets/images/                 # Signature image (optional)
├── output/                        # Generated PDFs (gitignored)
├── Makefile                       # Build commands
└── .github/workflows/build.yml    # CI/CD
```

## Data Files

After `make setup`, edit the files in `data/` with your information. No Typst knowledge needed — just plain TOML.

### `data/profile.toml` — Your identity

```toml
firstname = "John"
lastname = "Doe"
email = "john.doe@example.com"
phone = "(+1) 555-123-4567"
github = "johndoe"
linkedin = "johndoe"
homepage = "https://johndoe.dev"
positions = ["Senior Software Engineer"]
```

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

## Build Commands

```bash
make setup        # Copy example files (first-time only)
make all          # Build resume + cover letter
make resume       # Build resume only
make cover_letter # Build cover letter only
make watch-resume # Auto-rebuild on changes
make watch-cover  # Auto-rebuild cover letter on changes
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
)
```

### Multi-language Support

Set `language` to any of: `en`, `de`, `gr`, `pt`, `sp`, `fr`, `ru`, `zh`, `it`, `th`.

## CI/CD

GitHub Actions automatically compiles your PDFs on every push. Download from the Actions tab > latest run > Artifacts.

## Editor Setup

**VS Code:** Install [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) for live preview (`Cmd+K V`).

## License

MIT License. See [LICENSE](LICENSE).

Based on [Modern CV](https://github.com/DeveloperPaul123/modern-cv) by Paul Tsouchlos.
