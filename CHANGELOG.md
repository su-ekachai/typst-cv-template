# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-05-07

### Added
- Data-driven architecture: all CV content lives in TOML files (`data/`)
- Example data files (`data/*.example.toml`) for quick setup
- `make setup` command to initialize personal data from examples
- Conditional signature support via `use-signature` flag in cover letter TOML
- CLAUDE.md for AI-assisted development

### Changed
- **Breaking:** Content moved from inline `.typ` markup to TOML data files
- Templates (`src/*.typ`) now read from `data/*.toml` using Typst's native `toml()` function
- Personal data gitignored by default for safe public sharing
- GitHub Actions CI copies examples before compiling
- README rewritten for template-first workflow
- Makefile updated with `setup` target

### Removed
- Inline content from `.typ` source files (moved to TOML)

## [1.0.0] - 2024-12-05

### Added
- Initial resume template based on [modern-cv](https://github.com/DeveloperPaul123/modern-cv)
- Cover letter template
- GitHub Actions CI/CD for automatic PDF compilation
- Multi-language support via `lang.toml`
- Customizable accent colors and fonts
- Signature support for cover letters

### Credits
- Based on [Modern CV](https://github.com/DeveloperPaul123/modern-cv) by Paul Tsouchlos
- Inspired by [Awesome-CV](https://github.com/posquit0/Awesome-CV) LaTeX template
