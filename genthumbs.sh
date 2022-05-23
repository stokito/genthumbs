#!/bin/sh
# Check for dependencies
if ! type convert > /dev/null 2>&1; then
  echo "Imagemagick suite (convert) required but not installed, please install it with your package manager"
  exit 1
fi

if ! type md5sum > /dev/null 2>&1; then
  echo "md5sum required but not installed, please install it with your package manager"
  exit 1
fi

opti=1
if ! type optipng > /dev/null 2>&1; then
  echo "optipng is not installed. Execution will continue but resulting thumbnails will be larger and unoptimized"
  echo "For optimal results, install optipng with your package manager"
  opti=0
fi

# Loop files in current directory and generate thumbnails with proper metadata
for a in *.jp* *.JP*; do
  [ -f "$a" ] || continue
  ./genthumb.sh "$a" "$opti"
done
