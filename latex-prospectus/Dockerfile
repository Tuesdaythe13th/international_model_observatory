FROM texlive/texlive:latest

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /document

# Copy project files
COPY . .

# Install any missing LaTeX packages
RUN tlmgr update --self && \
    tlmgr install \
    mathpazo \
    helvet \
    microtype \
    geometry \
    parskip \
    fancyhdr \
    xcolor \
    tcolorbox \
    pgf \
    graphicx \
    wrapfig \
    caption \
    float \
    subcaption \
    listings \
    titlesec \
    enumitem \
    booktabs \
    tabularx \
    amsmath \
    amssymb \
    amsthm \
    hyperref \
    etoolbox \
    environ

# Default command: build the PDF
CMD ["make", "all"]
