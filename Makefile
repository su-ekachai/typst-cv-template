.PHONY: all resume cover_letter clean watch help setup

# Project root for Typst
ROOT := .

# Default target
all: resume cover_letter

# Build resume
resume:
	@echo "📝 Building resume..."
	@typst compile --root $(ROOT) src/resume.typ output/resume.pdf
	@echo "✅ output/resume.pdf created"

# Build cover letter
cover_letter:
	@echo "📝 Building cover letter..."
	@typst compile --root $(ROOT) src/cover_letter.typ output/cover_letter.pdf
	@echo "✅ output/cover_letter.pdf created"

# Watch mode for resume (auto-rebuild)
watch-resume:
	@echo "👀 Watching src/resume.typ for changes..."
	@typst watch --root $(ROOT) src/resume.typ output/resume.pdf

# Watch mode for cover letter (auto-rebuild)
watch-cover:
	@echo "👀 Watching src/cover_letter.typ for changes..."
	@typst watch --root $(ROOT) src/cover_letter.typ output/cover_letter.pdf

# Clean generated files
clean:
	@echo "🧹 Cleaning generated PDFs..."
	@rm -f output/*.pdf
	@echo "✅ Cleaned"

# Setup data files from examples (first-time setup)
setup:
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
	@echo "  make setup        - Copy example data files (first-time setup)"
	@echo "  make all          - Build both resume and cover letter"
	@echo "  make resume       - Build resume only"
	@echo "  make cover_letter - Build cover letter only"
	@echo "  make watch-resume - Watch and auto-rebuild resume"
	@echo "  make watch-cover  - Watch and auto-rebuild cover letter"
	@echo "  make clean        - Remove generated PDFs"
	@echo "  make help         - Show this help message"
