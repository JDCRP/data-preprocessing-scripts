# /bin/sh

echo 'Starting preprocessing.. '
cd ..

echo 'Resizing and reformatting TIFs as JPGs.. '
# Find the TIFs and bulk resize
find -iname '*.tif' -exec mogrify -resize 1092266@ -format jpg {} \; -exec echo ': Done' \;

# Copy JPGs and directory structure to jpg directory
echo 'Copying files to jpg directory.. '
rsync -a --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/

# Remove JPGs from tif directory
cd tif
find -iname '*.jpg' -exec rm {} +

cd ../jpg

# Remove whitespace and '(FINISHED)' from directories
echo 'Cleaning directory and file names.. '
find . -type d -exec rename -n 's/\s//' {} \; -exec rename -n 's/\(FINISHED\)//' {} \;

# Remove whitespace from filenames
find . -depth -iname '*.jpg' -type f -exec rename -n 's/\s//' {} +

echo 'Exporting filelist as CSV.. '
# Export dirlist/filelist as csv
find . -type f -printf '"%p",\n' > ../filelist.csv
echo 'Completed preprocessing successfully.. '

cd ../scripts
