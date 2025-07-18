#!/usr/bin/env bash
#
# script.sh -- loop adb screencap + swipe for a given count
#
# Usage: ./script.sh <count>
#   <count>  Number of times to capture & swipe

# Exit on any error
set -e

# Check for exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <count>"
  exit 1
fi

# Validate that the argument is a positive integer
if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
  echo "Error: count must be a positive integer."
  exit 1
fi

COUNT="$1"

echo "Starting: will capture & swipe $COUNT times..."

for ((i=1; i<=COUNT; i++)); do
  filename="screen-${i}.png"
  echo "[$i/$COUNT] Capturing to $filename ..."
  
  # Capture the screen from device
  adb exec-out screencap -p > "${filename}"

  echo "[$i/$COUNT] Swiping ..."
  # Swipe: from x=0,y=960 to x=1080,y=960
  adb shell input swipe 0 960 990 960

  # add a small delay for device render time
  sleep 0.3
done

echo "Done! Saved ${COUNT} screenshots (screen-1.png … screen-${COUNT}.png)."

