# /bin/sh

echo 'Starting preprocessing.. '
cd ..

# Find the TIFs and bulk resize
echo 'Resizing and reformatting TIFs as JPGs.. '

find -iname '*.tif' -exec mogrify -resize 1092266@ -format jpg {} \; -exec echo {}': Done' \;

# Move JPGs and directory structure to jpg directory
echo 'Copying files to jpg directory.. '

rsync -a --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/

# Remove JPGs from tif directory
cd tif
find -iname '*.jpg' -exec rm {} +

cd ../jpg

# Remove whitespace and '(FINISHED)' from directories
echo 'Cleaning directory and file names.. '

find . -type d -exec rename 's/\s//' {} \; -exec rename 's/\(FINISHED\)//' {} \;

# Remove whitespace from filenames
find -iname '*.jpg' -type f -exec rename 's/\s//' {} +
# Add underscore after Roll
find -iname '*.jpg' -type f -exec rename 's/Roll/Roll_/' {} +

# Export dirlist/filelist as csv
echo 'Exporting filelist as CSV.. '

find -type f -printf '"%p",\n' > ../filelist.csv

echo 'Completed preprocessing successfully.. '
cd ../scripts
