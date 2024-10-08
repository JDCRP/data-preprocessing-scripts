# /bin/sh

echo 'Starting resizing process.. \n'
echo -ne '                          (0%)\r'
cd ..

# Find the TIFs and bulk resize
find -iname '*.tif' -exec mogrify -resize 1092266@ -format jpg {} +
echo -ne '##########                (50%)\r'

# Copy JPGs and directory structure to jpg directory
rsync -a --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/
echo -ne '###############           (75%)\r'

# Remove JPGs from tif directory
cd tif
find -iname '*.jpg' -exec rm {} +
echo -ne '################          (80%)\r'

cd ../jpg

# Remove whitespace and '(FINISHED)' from directories
find . -type d -exec rename -n 's/\s//' {} \; -exec rename -n 's/\(FINISHED\)//' {} \;
echo -ne '#################         (85%)\r'

# Remove whitespace from filenames
find . -depth -iname '*.jpg' -type f -exec rename -n 's/\s//' {} +
echo -ne '###################       (95%)\r'

# Export dirlist/filelist as csv
find . -type f -printf '"%p",\n' > ../filelist.csv
echo -ne '####################       (100%)\r'
echo '\n'

cd ../scripts
