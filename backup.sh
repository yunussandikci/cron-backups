#!/bin/sh

upload_to_dropbox() {
    echo "Upload started to Dropbox folder: $FOLDER_NAME"
    FOLDER_NAME="$(date '+%d-%m-%Y-%H-%M-%S')"
    for file in /tmp/backup/*.z*
    do
        FILE_NAME=$(echo $file|grep -oE "[^/]+$")
        echo "$(date '+%d/%m/%Y %H:%M:%S') - ${FOLDER_NAME}/${FILE_NAME} upload started"
        curl -X POST https://content.dropboxapi.com/2/files/upload \
        --header "Authorization: Bearer ${DROPBOX_TOKEN}" \
        --header "Dropbox-API-Arg: {\"path\": \"/${FOLDER_NAME}/${FILE_NAME}\"}" \
        --header "Content-Type: application/octet-stream" \
        --data-binary @$file
        echo "$(date '+%d/%m/%Y %H:%M:%S') - ${FOLDER_NAME}/${FILE_NAME} upload finished"
    done
    echo "Upload finished to Dropbox."
}

echo "$(date '+%d/%m/%Y %H:%M:%S') - Backup started"
rm -rf /tmp/backup
mkdir /tmp/backup

echo "$(date '+%d/%m/%Y %H:%M:%S') - Compression started"
zip -r -s 150m /tmp/backup/backup.zip /backup > /tmp/backup-zip-$(date '+%d-%m-%Y-%H-%M-%S').log
echo "$(date '+%d/%m/%Y %H:%M:%S') - Compression finished"

upload_to_dropbox

rm -rf /tmp/backup
mkdir /tmp/backup
echo "$(date '+%d-%m-%Y-%H-%M-%S') - Backup finished."