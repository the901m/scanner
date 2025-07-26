 ## usage
ensure that you have `adb` set up correctly before running the script.
```
./auto.sh <count>
```
- Screenshots will be saved in the current directory, so make sure to run the script in an appropriate folder
### converting to pdf (easiest and fastest)
you can use imagemagick, install it with your package manager.
```
magick $(ls *.png | sort -V) -crop 1060x1530+10+370 +repage output.pdf 
```
- probably there is a smarter way to use trim and other options.
### converting to pdf (most efficient)
The smallest file size is achievable with the `-type Bilevel` option (magick), which converts the image to black and white.
- **ImageMagick for pixel-level cropping:**
```bash
for file in *.png; do
	magick "$file" -crop 1060x1530+10+370 +repage "${file%.png}_cropped.png"
done
```
- **`pngquant` for controlled lossy color reduction:**
```bash
for file in *_cropped.png; do
	pngquant --quality=50-70 --speed 1 --strip --ext .quant.png -- "$file"
done
```
- **`oxipng` for final lossless PNG structure optimization:**
```bash
oxipng -o max --strip safe --alpha "*_cropped.quant.png"
```

- **`img2pdf` for lossless PDF embedding:**
```bash
ls *_cropped.quant.png | sort -V | xargs img2pdf -o output_final_cropped.pdf
```
In one experiment, this method achieved a **45% reduction in file size** compared to the previous method, while maintaining better quality.

### ocr
follow complete instructure [here](https://github.com/ocrmypdf/OCRmyPDF).
but generally install ocrmypdf and your language tesseract engine.
```
ocrmypdf -l fas+eng output.pdf final.pdf
```
# IMPORTANT
- for Xiaomi devices make sure `USB debugging (security settings)` is allowed to take swipe input.
- for apps that restrict taking screenshots you have two options:
  1. root your device. (disable flag secure)
  2. use [android virtual engine](https://github.com/asLody/VirtualApp), I've tested [this app](https://github.com/WaxMoon/MultiApp) and it worked for me.
