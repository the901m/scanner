 ## usage
ensure that you have `adb` set up correctly before running the script.
```
./auto.sh <count>
```
- Screenshots will be saved in the current directory, so make sure to run the script in an appropriate folder
### converting to pdf
you can use imagemagick, install it with your package manager.
```
magick $(ls *.png | sort -V) -crop 1060x1530+10+370 +repage output.pdf 
```
- probably there is a smarter way to use trim and other options.
### ocr
follow complete instructure [here](https://github.com/ocrmypdf/OCRmyPDF).
but generally install ocrmypdf and your language tesseract engine.
```
ocrmypdf -l fas+eng output.pdf final.pdf
```
# IMPORTANT
- for Xiaomi devices make sure `USB debugging (security settings)` is allowed to take swipe input.
- for apps that restrict taking screenshots you have two options:
  1. root your device
  2. use [android virtual engine](https://github.com/asLody/VirtualApp), I've tested [this app](https://github.com/WaxMoon/MultiApp) and it worked for me.
