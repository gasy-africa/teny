#!/bin/bash

# Variables
PDF_FILE=$1
OUTPUT_TEXT_FILE=${PDF_FILE}.txt
IMAGE_PREFIX="page"
ENHANCED_IMAGE_PREFIX="page-enhanced"

# Step 1: Convert PDF to high-resolution images
echo "Converting PDF to images..."
pdftoppm -png -r 300 "$PDF_FILE" "$IMAGE_PREFIX"
if [ $? -ne 0 ]; then
    echo "Error: Failed to convert PDF to images."
    exit 1
fi

# Check if images were created
if ls ${IMAGE_PREFIX}-*.png 1> /dev/null 2>&1; then
    echo "Images successfully extracted."
else
    echo "Error: No images found. Conversion might have failed."
    exit 1
fi

# Step 2: Preprocess images
echo "Preprocessing images..."
for img in ${IMAGE_PREFIX}-*.png; do
    echo "Processing $img..."
    magick "$img" -colorspace Gray -level 0%,100%,0.5 "${ENHANCED_IMAGE_PREFIX}-${img##*/}"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to preprocess image $img."
        exit 1
    fi
done

# Step 3: Run Tesseract on each enhanced image
echo "Running Tesseract OCR..."
for img in ${ENHANCED_IMAGE_PREFIX}-*.png; do
    echo "Running Tesseract on $img..."
    tesseract "$img" "${img%.png}" -l eng
    if [ $? -ne 0 ]; then
        echo "Error: Tesseract failed on image $img."
        exit 1
    fi
done

# Step 4: Combine all text files into one
echo "Combining text files..."
cat ${ENHANCED_IMAGE_PREFIX}-*.txt > "$OUTPUT_TEXT_FILE"
if [ $? -ne 0 ]; then
    echo "Error: Failed to combine text files."
    exit 1
fi

# Cleanup intermediate files
echo "Cleaning up..."
rm ${IMAGE_PREFIX}-*.png
rm ${ENHANCED_IMAGE_PREFIX}-*.png
rm ${ENHANCED_IMAGE_PREFIX}-*.txt

echo "Processing completed successfully. Output saved to $OUTPUT_TEXT_FILE."

