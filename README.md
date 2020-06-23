# ⏱️📦 Cron Backups
Cron backups is a docker image to automate periodic backups easily to Dropbox with only one Docker container! 

## Features
- Auto compression 
- Periodic backups
- Multiple folder selection
- Tiny footprint (9Mb)
- Upload to Dropbox

## Configuration
You need to set your backup folders as volumes and 2 environment variables.

### Volumes
It backups every folder you mapped into `/backup` folder with volumes

### Environment Variables
`CRON`: Crontab value to set period of backups. Ref: https://crontab.guru/

`DROPBOX_TOKEN`: Access Token you get for Dropbox folder. Ref: https://www.dropbox.com/developers/apps/create

### Example
Edit docker-compose and run with `docker-compose up -d`
```
version: '3'
services:
  caddy:
    image: yunussandikci/cron-backups
    volumes:
    - /Users/yunussandikci/Pictures/:/backup/Pictures  
    - /Users/yunussandikci/Downloads/:/backup/Downloads
    - /Users/yunussandikCci/Documents/Zoom/:/backup/Zoom
    environment:
      CRON: "* * * * *" 
      DROPBOX_TOKEN: "<dropbox_token>"
```
