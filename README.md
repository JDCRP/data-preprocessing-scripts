# README.md

## Intro

This script takes TIF files from the /tif/ directory, and converts them to web-friendly jpg files. The directory structure from the /tif/ directory is recreated in the /jpg/ directory and the web-friendly jpgs are stored there. 

## Usage

- Move the new TIF files to the /tif/ directory
- cd to the /scripts/ directory
- run the script with 'sh nara-resize-webfriendly-7102924.sh' or './sh nara-resize-webfriendly-7102924.sh'
- The file 'filelist.txt' will be created in the project root directory, containing the filenames

## Requirements

Mogrify
Rsync
