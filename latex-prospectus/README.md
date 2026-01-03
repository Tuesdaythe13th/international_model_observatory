# Neural Forensics Prospectus - LaTeX Setup

This directory contains the LaTeX source for the **Neural Forensics of Agentic Self-Knowledge** research prospectus for MATS 10.0.

## Quick Start

### 1. Install LaTeX Distribution

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install texlive-full
```

**macOS:**
```bash
# Using Homebrew
brew install --cask mactex

# Or download from: https://www.tug.org/mactex/
```

**Windows:**
- Download MiKTeX: https://miktex.org/download
- Or use TeX Live via WSL (recommended)

### 2. Install Required Packages

Run the automated installation script:
```bash
./install-latex-packages.sh
```

Or install manually using `tlmgr` (TeX Live):
```bash
sudo tlmgr update --self
sudo tlmgr install mathpazo helvet microtype geometry parskip xcolor tcolorbox \
    graphicx wrapfig caption float subcaption listings titlesec enumitem \
    booktabs tabularx amsmath amssymb hyperref pgf etoolbox environ
```

### 3. Add Images

Place all required images in the `images/` directory:

```
images/
├── 02_hypothesis_diagram.png
├── 03_split_brain_concept.png
├── 04_sediment_timeline.png
├── 05_quadrant_analysis.png
├── 06_research_timeline.png
├── 08_transformer_layers.png
├── 09_title_hero.png
├── 10_cot_faithfulness.png
├── 11_strategic_fit.png
├── 14_void_fissure_specimen.png
├── 16_complete_toolkit.png
├── adt_methodology.png
└── dsmmd_taxonomy.png
```

### 4. Build the PDF

```bash
# Full build (multiple passes for references)
make

# Quick draft build (single pass)
make draft

# Auto-rebuild on changes (requires 'entr')
make watch

# View the PDF
make view
```

## Required LaTeX Packages

The prospectus uses the following LaTeX packages:

### Core Typography
- `inputenc` - UTF-8 input encoding
- `fontenc` - T1 font encoding
- `mathpazo` - Palatino font for text and math
- `helvet` - Helvetica font
- `microtype` - Typographic refinements

### Layout
- `geometry` - Page margins and layout
- `parskip` - Paragraph spacing

### Graphics & Colors
- `xcolor` - Color support
- `tcolorbox` - Colored boxes and highlights
- `graphicx` - Image inclusion
- `wrapfig` - Text wrapping around figures
- `caption`, `subcaption` - Figure captions
- `float` - Float positioning

### Code Listings
- `listings` - Syntax-highlighted code blocks

### Document Structure
- `titlesec` - Section heading formatting
- `enumitem` - List customization
- `booktabs` - Professional tables
- `tabularx` - Advanced table layouts

### Mathematics
- `amsmath`, `amssymb` - AMS math symbols and environments

### Hyperlinks
- `hyperref` - PDF hyperlinks and metadata

## Build Targets

| Command | Description |
|---------|-------------|
| `make` | Full build with multiple LaTeX passes |
| `make draft` | Quick single-pass build |
| `make clean` | Remove auxiliary files |
| `make cleanall` | Remove all build artifacts |
| `make view` | Open PDF with default viewer |
| `make watch` | Auto-rebuild on file changes |
| `make install-packages` | Run package installation script |
| `make help` | Show all available targets |

## Troubleshooting

### Missing Packages

If you encounter "File 'xxx.sty' not found" errors:

1. Run the installation script: `./install-latex-packages.sh`
2. Or install manually: `sudo tlmgr install <package-name>`
3. Update package database: `sudo tlmgr update --all`

### Font Issues

If you see warnings about missing fonts:

```bash
# TeX Live
sudo tlmgr install collection-fontsrecommended

# Or specific fonts
sudo tlmgr install mathpazo psnfss helvetic
```

### Image Not Found

Ensure all image files are in the `images/` directory and have `.png` extension.
The document expects the following images (see section 3 above).

### Build Fails on First Pass

This is normal if you have cross-references. Run `make` (not `make draft`) to perform multiple passes.

### Permission Denied on Script

Make the script executable:
```bash
chmod +x install-latex-packages.sh
```

## Document Structure

```
neural_forensics_prospectus.tex
├── Preamble (packages, styling, colors)
├── Title and Metadata
├── Executive Summary
│   ├── Problem Statement
│   ├── High-level Takeaways
│   ├── Key Experiments
│   ├── H-Score Metric
│   └── Strategic Fit
├── Main Content
│   ├── 1. Faithfulness Crisis
│   ├── 2. Specimen cb83
│   ├── 3. Methodology & ADT
│   ├── 4. Taxonomy (DSMMD v1.0)
│   ├── 5. Research Plan
│   └── 6. Appendix: Decoupling Gradient
└── End
```

## Customization

### Colors

The document uses a custom color palette defined in the preamble:

```latex
\definecolor{crimson}{RGB}{160, 0, 0}      % Headings, emphasis
\definecolor{obsidian}{RGB}{20, 20, 20}    % Dark text
\definecolor{codebg}{gray}{0.95}           % Code background
```

To modify colors, edit these definitions in the `.tex` file.

### Fonts

The prospectus uses Palatino (mathpazo) for body text and Helvetica (helvet) for headings.
To change fonts, modify the font packages in the preamble.

### Margins

Current margins are 0.8 inches. To adjust:

```latex
\usepackage[margin=0.8in]{geometry}
```

## Docker Alternative

If you prefer containerized LaTeX compilation:

```dockerfile
# Dockerfile (create in this directory)
FROM texlive/texlive:latest

WORKDIR /document
COPY . .

RUN pdflatex -interaction=nonstopmode neural_forensics_prospectus.tex && \
    pdflatex -interaction=nonstopmode neural_forensics_prospectus.tex

CMD ["pdflatex", "-interaction=nonstopmode", "neural_forensics_prospectus.tex"]
```

Build and run:
```bash
docker build -t neural-forensics-prospectus .
docker run --rm -v $(pwd):/document neural-forensics-prospectus
```

## Online Alternatives

If local LaTeX installation is challenging:

- **Overleaf**: https://www.overleaf.com (online LaTeX editor)
- **Papeeria**: https://papeeria.com
- **CoCalc**: https://cocalc.com

Simply upload `neural_forensics_prospectus.tex` and the `images/` folder.

## File Checklist

- [x] `neural_forensics_prospectus.tex` - Main LaTeX document
- [x] `Makefile` - Build automation
- [x] `install-latex-packages.sh` - Package installation script
- [x] `README.md` - This documentation
- [ ] `images/` - Image assets (must be added by user)

## License

This document is part of the MATS 10.0 application for research on Neural Forensics of Agentic Self-Knowledge.

**Applicant**: Tuesday (ARTIFEX Labs)
**Mentor**: Neel Nanda (Google DeepMind)
**Stream**: Mechanistic Interpretability

---

For questions or issues, please refer to the MATS program guidelines or contact the applicant.
