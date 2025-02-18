# /bin/sh

echo 'Starting preprocessing.. '
#cd ..
rm -r jpg/*

# Find the TIFs and bulk resize
echo 'Resizing and reformatting TIFs as JPGs.. '

#find -iname '*.tif' -exec mogrify -resize 1092266@ -format jpg {} \; -exec echo {}': Done' \;
find -iname '*.tif' -exec mogrify -format jpg -quality 90 {} \; -exec echo {}': Done' \;

# Move JPGs and directory structure to jpg directory
echo 'Copying files to jpg directory.. '

rsync -a --info=progress2 --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/

# Remove JPGs from tif directory
cd tif
find -iname '*.jpg' -exec rm {} +

cd ../jpg

# Remove whitespace and '(FINISHED)' from directories
echo 'Cleaning directory and file names.. '

find -type d -exec rename 's/\s//' * {} +
find -type d -exec rename 's/\(FINISHED\)//' {} +
find -type d -exec rename 's/#//' {} +
#find -type d -exec rename 's/Roll/Roll_/' {} +

# Remove whitespace from filenames
find -iname '*.jpg' -type f -exec rename 's/\s//' * {} +

# Export dirlist/filelist as csv
echo 'Exporting filelist as CSV.. '

#find -type f -printf '"%p",\n' > ../filelist.csv
find -iname '*.jpg' -type f -printf '%p\n' > ../filelist-3.csv

echo 'Completed preprocessing successfully.. '
echo 'Copying files to nara-upload..'

#C:\Users\User\Workspace\JDCRP
cd ..
cp -r jpg /mnt/c/Users/User/Workspace/JDCRP/nara-upload
