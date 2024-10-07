# /bin/sh

cd ..
find -iname '*.tif' -exec mogrify -resize 1092266@ -format jpg {} +
rsync -a --include '*/' --include '*.jpg' --exclude '*' tif/ jpg/
cd tif
find -iname '*.jpg' -exec rm {} +
cd ../jpg
find . -type f >> ../filelist.txt
cd ../scripts
