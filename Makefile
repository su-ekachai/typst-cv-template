.PHONY: all resume cover_letter watch-resume watch-cover clean help setup check-clean hooks verify

# Project root for Typst
ROOT := .

# Default target
all: resume cover_letter

# Build resume → output/resume.pdf
resume:
	@echo "📝 Building resume..."
	@typst compile --root $(ROOT) --font-path assets/fonts src/resume.typ output/resume.pdf
	@echo "✅ output/resume.pdf created"

# Build cover letter
cover_letter:
	@echo "📝 Building cover letter..."
	@typst compile --root $(ROOT) --font-path assets/fonts src/cover_letter.typ output/cover_letter.pdf
	@echo "✅ output/cover_letter.pdf created"

# Watch mode for resume (auto-rebuild)
watch-resume:
	@echo "👀 Watching src/resume.typ for changes..."
	@typst watch --root $(ROOT) --font-path assets/fonts src/resume.typ output/resume.pdf

# Watch mode for cover letter (auto-rebuild)
watch-cover:
	@echo "👀 Watching src/cover_letter.typ for changes..."
	@typst watch --root $(ROOT) --font-path assets/fonts src/cover_letter.typ output/cover_letter.pdf

# Verify: privacy guard + full build (local mirror of CI) — run before pushing
verify: check-clean resume cover_letter
	@echo "✅ Verify passed: no personal data staged, both documents build."

# Clean generated files
clean:
	@echo "🧹 Cleaning generated PDFs..."
	@rm -f output/*.pdf
	@echo "✅ Cleaned"

# Guard: fail if any personal data is staged for commit (defense-in-depth on top of .gitignore)
check-clean:
	@echo "🔒 Checking staged files for personal data..."
	@bad=$$(git diff --cached --name-only | grep -E '^(data/.*\.toml|assets/images/|local/)' | grep -vE '^(data/.*\.example\.toml|assets/images/\.gitkeep)$$' || true); \
	if [ -n "$$bad" ]; then \
		echo "❌ Refusing: personal data is staged (do NOT commit):"; \
		echo "$$bad" | sed 's/^/   /'; \
		echo "   Unstage with: git restore --staged <file>"; \
		exit 1; \
	else \
		echo "✅ No personal data staged."; \
	fi

# Install git hooks (privacy pre-commit guard) for this clone
hooks:
	@git config core.hooksPath .githooks
	@chmod +x .githooks/* 2>/dev/null || true
	@echo "🔒 Git hooks enabled (core.hooksPath → .githooks)"

# Setup data files from examples + install hooks (first-time setup)
setup: hooks
	@echo "📋 Setting up from example files..."
	@for f in data/*.example.toml; do \
		target=$${f%.example.toml}.toml; \
		if [ ! -f "$$target" ]; then \
			cp "$$f" "$$target"; \
			echo "  Created $$target"; \
		else \
			echo "  Skipped $$target (already exists)"; \
		fi \
	done
	@echo "✅ Done! Edit the files in data/ with your information."

# Show help
help:
	@echo "Available targets:"
	@echo "  make setup        - Copy example data files + install git hooks (first-time)"
	@echo "  make all          - Build both resume and cover letter"
	@echo "  make resume       - Build resume → output/resume.pdf"
	@echo "  make cover_letter - Build cover letter only"
	@echo "  make watch-resume - Watch and auto-rebuild resume"
	@echo "  make watch-cover  - Watch and auto-rebuild cover letter"
	@echo "  make verify       - Privacy guard + build both (run before pushing)"
	@echo "  make check-clean  - Fail if personal data is staged for commit"
	@echo "  make hooks        - Install the privacy pre-commit hook"
	@echo "  make clean        - Remove generated PDFs"
	@echo "  make help         - Show this help message"
