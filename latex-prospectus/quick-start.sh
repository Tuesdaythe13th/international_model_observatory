#!/bin/bash

###################################################################################
# Quick Start Script for Neural Forensics Prospectus
#
# This script guides you through the complete setup process.
###################################################################################

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Neural Forensics Prospectus - Quick Start Setup          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Step 1: Check for LaTeX installation
echo "Step 1: Checking LaTeX installation..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command_exists pdflatex; then
    LATEX_VERSION=$(pdflatex --version | head -n1)
    echo "✓ LaTeX found: $LATEX_VERSION"
else
    echo "✗ LaTeX not found"
    echo ""
    echo "Please install a LaTeX distribution:"
    echo ""
    echo "  Ubuntu/Debian:  sudo apt-get install texlive-full"
    echo "  macOS:          brew install --cask mactex"
    echo "  Windows:        Download from https://miktex.org/"
    echo ""
    exit 1
fi

echo ""

# Step 2: Install packages
echo "Step 2: Installing required LaTeX packages..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "install-latex-packages.sh" ]; then
    read -p "Run package installation script? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash install-latex-packages.sh
    else
        echo "Skipping package installation."
        echo "Note: Build may fail if packages are missing."
    fi
else
    echo "⚠ install-latex-packages.sh not found"
fi

echo ""

# Step 3: Check for images
echo "Step 3: Checking for required images..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

REQUIRED_IMAGES=(
    "02_hypothesis_diagram.png"
    "03_split_brain_concept.png"
    "04_sediment_timeline.png"
    "05_quadrant_analysis.png"
    "06_research_timeline.png"
    "08_transformer_layers.png"
    "09_title_hero.png"
    "10_cot_faithfulness.png"
    "11_strategic_fit.png"
    "14_void_fissure_specimen.png"
    "16_complete_toolkit.png"
    "adt_methodology.png"
    "dsmmd_taxonomy.png"
)

MISSING_COUNT=0
for img in "${REQUIRED_IMAGES[@]}"; do
    if [ -f "images/$img" ]; then
        echo "✓ $img"
    else
        echo "✗ $img (missing)"
        ((MISSING_COUNT++))
    fi
done

echo ""
if [ $MISSING_COUNT -gt 0 ]; then
    echo "⚠ $MISSING_COUNT image(s) missing"
    echo ""
    echo "Options:"
    echo "  1. Add your images to the images/ directory"
    echo "  2. Generate placeholders (see images/README.md)"
    echo "  3. Comment out image references in the .tex file"
    echo ""

    if command_exists convert; then
        read -p "Generate placeholder images? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Generating placeholders..."
            cd images
            for img in "${REQUIRED_IMAGES[@]}"; do
                if [ ! -f "$img" ]; then
                    NAME=$(basename "$img" .png)
                    convert -size 1200x800 xc:lightgray -pointsize 36 \
                            -gravity center -fill gray30 \
                            -annotate +0+0 "$NAME\n(placeholder)" "$img"
                    echo "  Created: $img"
                fi
            done
            cd ..
            echo "✓ Placeholders created"
        fi
    else
        echo "Install ImageMagick to auto-generate placeholders:"
        echo "  Ubuntu: sudo apt-get install imagemagick"
        echo "  macOS:  brew install imagemagick"
    fi
else
    echo "✓ All images present"
fi

echo ""

# Step 4: Build the document
echo "Step 4: Building the PDF..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

read -p "Build the PDF now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "Makefile" ]; then
        make
        echo ""
        echo "✓ Build complete!"

        if [ -f "neural_forensics_prospectus.pdf" ]; then
            read -p "Open the PDF? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                make view || echo "Please open neural_forensics_prospectus.pdf manually"
            fi
        fi
    else
        echo "Makefile not found. Building manually..."
        pdflatex neural_forensics_prospectus.tex
        pdflatex neural_forensics_prospectus.tex
    fi
else
    echo "Skipping build. Run 'make' when ready."
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Setup Complete!                                           ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  • Add/replace images in images/ directory"
echo "  • Edit neural_forensics_prospectus.tex as needed"
echo "  • Run 'make' to rebuild"
echo "  • Run 'make help' to see all build options"
echo ""
echo "Useful commands:"
echo "  make          Full build"
echo "  make draft    Quick build (faster iteration)"
echo "  make watch    Auto-rebuild on changes"
echo "  make clean    Remove build artifacts"
echo "  make view     Open PDF"
echo ""
