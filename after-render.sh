#!/bin/bash

# Move compiled readme in gfm format to home directory
# so it shows up on project page
cp docs/README.md .
# Move html/lib files to docs so that plotly stuff renders properly
cp -r slides/html/lib docs/slides/html
