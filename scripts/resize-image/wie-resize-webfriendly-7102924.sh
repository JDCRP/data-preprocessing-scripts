# /bin/sh

echo 'Starting preprocessing.. '
cd ..
rm -r jpg/*


# Find the TIFs and bulk resize
echo 'Resizing and reformatting TIFs as JPGs.. '

find -iname '*.jpg' -exec mogrify -resize 1092266@ -format jpg {} \; -exec echo {}': Done' \;

# Move JPGs and directory structure to jpg directory
echo 'Copying files to jpg directory.. '

rsync -a --info=progress2 --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/

# Remove JPGs from tif directory
cd tif
find -iname '*.jpg' -exec rm {} +

cd ../jpg

# Remove whitespace and '(FINISHED)' from directories
echo 'Cleaning directory and file names.. '

find -type d -exec rename 's/\s/_/' * {} +
find -type d -exec rename 's/\(FINISHED\)//' {} +
find -type d -exec rename 's/#//' {} +
find -type d -exec rename 's/Roll/Roll_/' {} +

# Remove whitespace from filenames
find -iname '*.jpg' -type f -exec rename 's/\s//' * {} +

# Export dirlist/filelist as csv
echo 'Exporting filelist as CSV.. '

find -type f -printf '"%p",\n' > ../filelist.csv

echo 'Completed preprocessing successfully.. '
cd ../scripts
