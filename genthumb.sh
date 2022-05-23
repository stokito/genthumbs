#!/bin/sh
# OptiPNG level of optimization. 7 is best, but it's very slow
PNGOPTLEVEL=7
a="$1"
opti="$2"

# Create subdirectories if needed
mkdir -p .sh_thumbnails/normal
mkdir -p .sh_thumbnails/large

echo "Generating thumbnails for $a..."
md5=$(echo -n "$a" | md5sum | cut -d " " -f1)
mtime=$(stat -c '%Y' "$a")
icon=".sh_thumbnails/normal/$md5.png"
[ -f "$icon" ] || convert -define jpeg:size=256x256 -auto-orient -thumbnail 128 -set Thumb::MTime "$mtime" -set Thumb::URI "$a" "$a" "$icon" \
  && [ $opti -eq 1 ] && optipng -o$PNGOPTLEVEL -quiet "$icon"
icon=".sh_thumbnails/large/$md5.png"
[ -f "$icon" ] || convert -define jpeg:size=512x512 -auto-orient -thumbnail 256 -set Thumb::MTime "$mtime" -set Thumb::URI "$a" "$a" "$icon" \
  && [ $opti -eq 1 ] && optipng -o$PNGOPTLEVEL -quiet "$icon"
