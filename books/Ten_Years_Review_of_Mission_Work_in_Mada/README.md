Downloading books from Google Books depends on the availability and the specific policies for each book. Here's a general guide on how you can do it:

### Free Books
1. **Search for the Book**: Go to [Google Books](https://books.google.com) and search for the book you want.
2. **Check Availability**: Some books are available for free download. Look for a "Read" or "Download" button.
3. **Download**: If the book is available for download, you will see options like "PDF" or "EPUB". Click on the desired format to download the book.

### Purchased Books
1. **Purchase the Book**: If the book is not free, you will need to purchase it. Follow the on-screen instructions to buy the book.
2. **My Books**: After purchasing, go to the "My Books" section in your Google Play Books account.
3. **Download**: Click on the three dots next to the book title and select "Download PDF" or "Download EPUB".

### Using Google Play Books App
1. **Install the App**: Download and install the Google Play Books app on your device.
2. **Sign In**: Sign in with your Google account.
3. **Library**: Go to your library where you can see all your purchased or free books.
4. **Download**: Tap on the book you want to download and it will be saved for offline reading.

### Downloading a Preview
If a book is only available for preview:
1. **Preview the Book**: Open the book preview in Google Books.
2. **Screenshot**: Take screenshots of the pages you want, though this is not ideal for extensive reading.

### Third-Party Tools (Not Recommended)
There are third-party tools and websites that claim to download books from Google Books. However, these may be illegal or unsafe. Always adhere to copyright laws and Google’s terms of service.

If you have specific questions or run into issues while trying to download a book, feel free to ask!

The error you encountered indicates that Tesseract, through Leptonica (the image processing library it uses), does not support reading PDF files directly. Instead, you need to convert your PDF to images first. Here's a step-by-step guide on how to do that:

### Step 1: Convert PDF to Images
You can use tools like `pdfimages` from the Poppler utilities or `ImageMagick` to convert each page of the PDF into an image.

#### Using `pdfimages`
1. **Install Poppler Utilities**:
   - On Ubuntu/Debian:
     ```sh
     sudo apt-get install poppler-utils
     ```
   - On macOS (using Homebrew):
     ```sh
     brew install poppler
     ```
2. **Extract Images**:
   ```sh
   pdfimages -png Ten_Years_Review_of_Mission_Work_in_Mada.pdf page
   ```
   This will create image files named `page-000.png`, `page-001.png`, etc., for each page in the PDF.

#### Using `ImageMagick`
1. **Install ImageMagick**:
   - On Ubuntu/Debian:
     ```sh
     sudo apt-get install imagemagick
     ```
   - On macOS (using Homebrew):
     ```sh
     brew install imagemagick
     ```
2. **Convert PDF to Images**:
   ```sh
   convert -density 300 Ten_Years_Review_of_Mission_Work_in_Mada.pdf page.png
   ```
   This will create image files named `page-0.png`, `page-1.png`, etc.

### Step 2: Run Tesseract OCR on Images
1. **Run Tesseract**:
   ```sh
   tesseract page-000.png output-page-000 -l eng
   tesseract page-001.png output-page-001 -l eng
   ```
   Repeat this command for each image file generated from the PDF.

### Step 3: Combine Text Files (Optional)
If you want to combine all the text files into one, you can use the following command:
```sh
cat output-page-*.txt > output.txt
```

### Complete Bash Script Example
Here’s a complete bash script to automate the entire process:

```sh
#!/bin/bash

# Variables
PDF_FILE="Ten_Years_Review_of_Mission_Work_in_Mada.pdf"
OUTPUT_TEXT_FILE="output.txt"
IMAGE_PREFIX="page"

# Convert PDF to images
pdfimages -png "$PDF_FILE" "$IMAGE_PREFIX"

# Run Tesseract on each image
for img in ${IMAGE_PREFIX}-*.png; do
  tesseract "$img" "${img%.png}" -l eng
done

# Combine all text files into one
cat ${IMAGE_PREFIX}-*.txt > "$OUTPUT_TEXT_FILE"

# Cleanup intermediate image and text files if desired
rm ${IMAGE_PREFIX}-*.png
rm ${IMAGE_PREFIX}-*.txt
```

Save this script as `convert_pdf_to_text.sh`, give it execute permissions, and run it:
```sh
chmod +x convert_pdf_to_text.sh
./convert_pdf_to_text.sh
```

This script will handle converting the PDF to images, running Tesseract OCR on each image, and combining the resulting text files into one document.

The warnings and messages you're seeing suggest that there may be issues with the font or the quality of the images extracted from the PDF. Here are some steps to help improve the OCR process:

### Step 1: Verify and Improve Image Quality
Make sure the images extracted from the PDF are of high quality. If they are not, try increasing the resolution when converting the PDF to images.

#### Using `pdfimages` with `-r` option:
```sh
pdfimages -png -r 300 Ten_Years_Review_of_Mission_Work_in_Mada.pdf page
```
The `-r 300` option sets the resolution to 300 DPI (dots per inch), which is usually good for OCR.

#### Using `ImageMagick` with `-density` option:
```sh
convert -density 300 Ten_Years_Review_of_Mission_Work_in_Mada.pdf page.png
```
The `-density 300` option sets the resolution to 300 DPI.

### Step 2: Preprocess Images (Optional but Recommended)
Preprocessing images can significantly improve OCR results. You can use `ImageMagick` to enhance the images.

#### Convert to Grayscale:
```sh
convert page-*.png -colorspace Gray page-gray.png
```

#### Enhance Contrast:
```sh
convert page-*.png -contrast -contrast -contrast page-enhanced.png
```

### Step 3: Run Tesseract OCR on Enhanced Images
Run Tesseract on the preprocessed images:

```sh
tesseract page-enhanced-000.png output-page-000 -l eng
tesseract page-enhanced-001.png output-page-001 -l eng
```

### Step 4: Combine Text Files (Optional)
Combine the text files into one:

```sh
cat output-page-*.txt > output.txt
```

### Complete Bash Script with Preprocessing
Here's a complete script incorporating preprocessing:

```sh
#!/bin/bash

# Variables
PDF_FILE="Ten_Years_Review_of_Mission_Work_in_Mada.pdf"
OUTPUT_TEXT_FILE="output.txt"
IMAGE_PREFIX="page"
ENHANCED_IMAGE_PREFIX="page-enhanced"

# Convert PDF to images with high resolution
pdfimages -png -r 300 "$PDF_FILE" "$IMAGE_PREFIX"

# Preprocess images: convert to grayscale and enhance contrast
for img in ${IMAGE_PREFIX}-*.png; do
  convert "$img" -colorspace Gray -contrast -contrast -contrast "${ENHANCED_IMAGE_PREFIX}-${img##*/}"
done

# Run Tesseract on each enhanced image
for img in ${ENHANCED_IMAGE_PREFIX}-*.png; do
  tesseract "$img" "${img%.png}" -l eng
done

# Combine all text files into one
cat ${ENHANCED_IMAGE_PREFIX}-*.txt > "$OUTPUT_TEXT_FILE"

# Cleanup intermediate image and text files if desired
rm ${IMAGE_PREFIX}-*.png
rm ${ENHANCED_IMAGE_PREFIX}-*.png
rm ${ENHANCED_IMAGE_PREFIX}-*.txt
```

Save this script as `convert_pdf_to_text_with_preprocessing.sh`, give it execute permissions, and run it:

```sh
chmod +x convert_pdf_to_text_with_preprocessing.sh
./convert_pdf_to_text_with_preprocessing.sh
```

This script will handle converting the PDF to high-resolution images, preprocessing the images to improve OCR accuracy, running Tesseract on each image, and combining the resulting text files into one document.

# References

- [ ] [Ten Years' Review of Mission Work in Madagascar, 1870-1880](https://books.google.ca/books?id=--slAQAAIAAJ)
