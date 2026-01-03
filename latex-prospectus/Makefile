# =============================================================================
# Makefile for Neural Forensics Prospectus
# =============================================================================

# LaTeX compiler
LATEX = pdflatex
BIBTEX = bibtex

# Main document
MAIN = neural_forensics_prospectus
SOURCE = $(MAIN).tex
OUTPUT = $(MAIN).pdf

# Build directory
BUILD_DIR = build

# Compiler flags
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD_DIR)

# =============================================================================
# Targets
# =============================================================================

.PHONY: all clean cleanall view help install-packages

# Default target: build the PDF
all: $(OUTPUT)

# Build the PDF (multiple passes for references and TOC)
$(OUTPUT): $(SOURCE)
	@echo "=================================================="
	@echo "Building Neural Forensics Prospectus PDF..."
	@echo "=================================================="
	@mkdir -p $(BUILD_DIR)
	@echo ""
	@echo "→ First pass (generating references)..."
	$(LATEX) $(LATEX_FLAGS) $(SOURCE)
	@echo ""
	@echo "→ Second pass (resolving references)..."
	$(LATEX) $(LATEX_FLAGS) $(SOURCE)
	@echo ""
	@echo "→ Moving PDF to project root..."
	@mv $(BUILD_DIR)/$(OUTPUT) .
	@echo ""
	@echo "=================================================="
	@echo "✓ Build complete: $(OUTPUT)"
	@echo "=================================================="

# Quick build (single pass, faster for draft iterations)
draft: $(SOURCE)
	@echo "Building draft (single pass)..."
	@mkdir -p $(BUILD_DIR)
	$(LATEX) $(LATEX_FLAGS) $(SOURCE)
	@mv $(BUILD_DIR)/$(OUTPUT) .
	@echo "✓ Draft build complete: $(OUTPUT)"

# Clean auxiliary files
clean:
	@echo "Cleaning auxiliary files..."
	@rm -rf $(BUILD_DIR)
	@rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
	@echo "✓ Clean complete"

# Clean everything including the PDF
cleanall: clean
	@echo "Removing PDF output..."
	@rm -f $(OUTPUT)
	@echo "✓ All build artifacts removed"

# View the PDF (platform-dependent)
view: $(OUTPUT)
	@if command -v xdg-open > /dev/null; then \
		xdg-open $(OUTPUT); \
	elif command -v open > /dev/null; then \
		open $(OUTPUT); \
	elif command -v start > /dev/null; then \
		start $(OUTPUT); \
	else \
		echo "Cannot detect PDF viewer. Please open $(OUTPUT) manually."; \
	fi

# Install required LaTeX packages
install-packages:
	@echo "Running LaTeX package installation script..."
	@bash install-latex-packages.sh

# Watch mode: rebuild on file changes (requires entr or inotifywait)
watch:
	@if command -v entr > /dev/null; then \
		echo "Watching for changes (press Ctrl+C to stop)..."; \
		ls $(SOURCE) images/*.png | entr -c make draft; \
	elif command -v inotifywait > /dev/null; then \
		echo "Watching for changes (press Ctrl+C to stop)..."; \
		while true; do \
			inotifywait -e modify $(SOURCE) images/*.png 2>/dev/null && make draft; \
		done; \
	else \
		echo "ERROR: 'entr' or 'inotifywait' required for watch mode."; \
		echo "Install with: sudo apt-get install entr (or brew install entr on macOS)"; \
		exit 1; \
	fi

# Help target
help:
	@echo "=================================================="
	@echo "Neural Forensics Prospectus - Build System"
	@echo "=================================================="
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo "  make              Build the complete PDF (default)"
	@echo "  make draft        Quick build (single LaTeX pass)"
	@echo "  make clean        Remove auxiliary build files"
	@echo "  make cleanall     Remove all build artifacts including PDF"
	@echo "  make view         Open the PDF with default viewer"
	@echo "  make watch        Auto-rebuild on file changes"
	@echo "  make install-packages  Install required LaTeX packages"
	@echo "  make help         Show this help message"
	@echo ""
	@echo "Prerequisites:"
	@echo "  - LaTeX distribution (TeX Live, MiKTeX, or MacTeX)"
	@echo "  - Required packages (run 'make install-packages')"
	@echo "  - Images in images/ directory"
	@echo ""
