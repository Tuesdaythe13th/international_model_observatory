#!/bin/bash

###################################################################################
# LaTeX Package Installation Script for Neural Forensics Prospectus
#
# This script installs all required LaTeX packages for compiling the prospectus.
# Supports: TeX Live (Linux/Mac), MiKTeX (Windows via WSL), and MacTeX (macOS)
###################################################################################

set -e  # Exit on error

echo "=================================================="
echo "Neural Forensics Prospectus - LaTeX Setup"
echo "=================================================="
echo ""

# Detect the LaTeX distribution
detect_latex_dist() {
    if command -v tlmgr &> /dev/null; then
        echo "texlive"
    elif command -v mpm &> /dev/null; then
        echo "miktex"
    else
        echo "unknown"
    fi
}

LATEX_DIST=$(detect_latex_dist)

if [ "$LATEX_DIST" = "unknown" ]; then
    echo "ERROR: No LaTeX distribution detected."
    echo ""
    echo "Please install one of the following:"
    echo "  - TeX Live: https://www.tug.org/texlive/"
    echo "  - MiKTeX: https://miktex.org/"
    echo "  - MacTeX (macOS): https://www.tug.org/mactex/"
    echo ""
    exit 1
fi

echo "Detected LaTeX distribution: $LATEX_DIST"
echo ""

# Core packages required by the prospectus
PACKAGES=(
    # Core LaTeX packages
    "latex"
    "latex-bin"

    # Font packages
    "inputenc"
    "fontenc"
    "mathpazo"          # Palatino font
    "psnfss"            # PostScript font support (includes mathpazo)
    "helvet"            # Helvetica font
    "microtype"         # Typography improvements

    # Page layout
    "geometry"
    "parskip"
    "fancyhdr"          # Headers and footers

    # Colors and graphics
    "xcolor"
    "tcolorbox"
    "pgf"               # Required by tcolorbox
    "graphics"
    "graphicx"
    "wrapfig"
    "caption"
    "float"
    "subcaption"

    # Code listings
    "listings"

    # Document structure
    "titlesec"
    "enumitem"
    "booktabs"
    "tabularx"

    # Math
    "amsmath"
    "amssymb"
    "amsfonts"
    "amsthm"            # Theorem environments

    # Hyperlinks
    "hyperref"
    "url"

    # Additional tcolorbox libraries
    "etoolbox"
    "environ"
)

# Function to install packages using tlmgr (TeX Live)
install_with_tlmgr() {
    echo "Installing packages using tlmgr..."
    echo ""

    # Update tlmgr itself
    echo "Updating tlmgr..."
    sudo tlmgr update --self 2>/dev/null || tlmgr update --self

    # Install packages
    for pkg in "${PACKAGES[@]}"; do
        echo "Installing $pkg..."
        sudo tlmgr install "$pkg" 2>/dev/null || tlmgr install "$pkg" || echo "  → $pkg may already be installed or is part of base installation"
    done

    echo ""
    echo "✓ Package installation complete (TeX Live)"
}

# Function to install packages using mpm (MiKTeX)
install_with_mpm() {
    echo "Installing packages using MiKTeX Package Manager..."
    echo ""

    # Update MiKTeX
    echo "Updating MiKTeX..."
    mpm --update-db

    # Install packages
    for pkg in "${PACKAGES[@]}"; do
        echo "Installing $pkg..."
        mpm --install="$pkg" || echo "  → $pkg may already be installed or is part of base installation"
    done

    echo ""
    echo "✓ Package installation complete (MiKTeX)"
}

# Install packages based on detected distribution
case "$LATEX_DIST" in
    "texlive")
        install_with_tlmgr
        ;;
    "miktex")
        install_with_mpm
        ;;
    *)
        echo "ERROR: Unknown LaTeX distribution"
        exit 1
        ;;
esac

# Verify installation by checking for key executables
echo ""
echo "Verifying installation..."
echo ""

REQUIRED_COMMANDS=("pdflatex" "latex")
ALL_OK=true

for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if command -v "$cmd" &> /dev/null; then
        VERSION=$($cmd --version | head -n1)
        echo "✓ $cmd: $VERSION"
    else
        echo "✗ $cmd: NOT FOUND"
        ALL_OK=false
    fi
done

echo ""

if [ "$ALL_OK" = true ]; then
    echo "=================================================="
    echo "✓ LaTeX environment is ready!"
    echo "=================================================="
    echo ""
    echo "Next steps:"
    echo "  1. Add your images to: latex-prospectus/images/"
    echo "  2. Build the PDF: cd latex-prospectus && make"
    echo ""
else
    echo "=================================================="
    echo "⚠ Some components are missing"
    echo "=================================================="
    echo ""
    echo "Please ensure your LaTeX distribution is fully installed."
    exit 1
fi
