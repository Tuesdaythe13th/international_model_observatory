# Images Directory

This directory should contain all images referenced in the Neural Forensics prospectus.

## Required Images

The LaTeX document expects the following PNG images:

1. **`02_hypothesis_diagram.png`** - Diagram showing causal coupling vs. dissociated confabulation hypotheses
2. **`03_split_brain_concept.png`** - Illustration of Actor vs. Narrator circuit dissociation
3. **`04_sediment_timeline.png`** - Timeline of Specimen cb83 behavioral anomaly
4. **`05_quadrant_analysis.png`** - ADT Quadrant diagram showing operational regions
5. **`06_research_timeline.png`** - 8-week research sprint timeline
6. **`08_transformer_layers.png`** - Localization of mid-layer vs. late-layer circuits
7. **`09_title_hero.png`** - Title hero image for document header
8. **`10_cot_faithfulness.png`** - The Faithfulness Gap illustration
9. **`11_strategic_fit.png`** - Strategic fit diagram for pragmatic interpretability
10. **`14_void_fissure_specimen.png`** - Specimen 485f signature visualization
11. **`16_complete_toolkit.png`** - Research stack workflow diagram
12. **`adt_methodology.png`** - ADT causal assay methodology diagram
13. **`dsmmd_taxonomy.png`** - DSMMD v1.0 pathology classification

## Image Specifications

- **Format**: PNG (recommended) or JPEG
- **Resolution**: 300 DPI minimum for print quality
- **Width**: 1200-2400 pixels for full-width images
- **Color space**: RGB

## Placeholder Generation

If you need to build the document without images, you can generate placeholders:

```bash
# Install ImageMagick if not available
sudo apt-get install imagemagick  # Linux
brew install imagemagick          # macOS

# Generate placeholder images
for img in 02_hypothesis_diagram 03_split_brain_concept 04_sediment_timeline \
           05_quadrant_analysis 06_research_timeline 08_transformer_layers \
           09_title_hero 10_cot_faithfulness 11_strategic_fit \
           14_void_fissure_specimen 16_complete_toolkit adt_methodology \
           dsmmd_taxonomy; do
    convert -size 1200x800 xc:lightgray -pointsize 48 -gravity center \
            -annotate +0+0 "$img\n(placeholder)" "${img}.png"
done
```

## Adding Your Images

1. Place all PNG files in this directory
2. Ensure filenames match exactly (case-sensitive)
3. Run `make` in the parent directory to build the PDF

## Troubleshooting

**"File not found" error**:
- Check that image filenames match exactly (including case)
- Verify files are in `images/` subdirectory
- Ensure file extensions are `.png`

**Images appear low quality**:
- Use higher resolution source images (300+ DPI)
- Export diagrams as vector graphics first, then convert to high-res PNG
