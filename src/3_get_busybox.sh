#!/bin/sh

echo "start get busybox...."

if [ -f ./source/busybox*.tar.bz2 ]
then
    exit 0
fi

# Grab everything after the '=' character
DOWNLOAD_URL=$(grep -i BUSYBOX_SOURCE_URL .config | cut -f2 -d'=')

# Grab everything after the last '/' character
ARCHIVE_FILE=${DOWNLOAD_URL##*/}

cd source

# Downloading busybox source
# -c option allows the download to resume
wget -c $DOWNLOAD_URL

# Delete folder with previously extracted busybox
# Extract busybox to folder 'busybox'
# Full path will be something like 'busybox\busybox-1.22.1'
# rm -rf ../work/busybox

if [ ! -x ../work/busybox ]
then
    mkdir ../work/busybox
    tar -xvf $ARCHIVE_FILE -C ../work/busybox
fi

cd ..
