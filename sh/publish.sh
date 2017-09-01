#! /bin/sh

ONLINE_PATH=/var/site/blogsite
REMOTE_SERVER=root@47.52.28.247

SOURCE_FILES=/Users/liuxuehao/Documents/blogsite/qianshui

ssh ${REMOTE_SERVER} 'mkdir -p ${ONLINE_PATH}'
rsync -rvI --delete-after --progress ${SOURCE_FILES} ${REMOTE_SERVER}:${ONLINE_PATH}
ssh -f -n ${REMOTE_SERVER} "/var/site/blogsite/qianshui/server-publish.sh &"