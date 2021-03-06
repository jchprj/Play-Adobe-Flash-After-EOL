ln -s /firefox/firefox /usr/bin/firefox
ln -s /player/flashplayer /usr/bin/flashplayer
ln -s /player/flashplayerdebugger /usr/bin/flashplayerdebugger
if [ "$STARTUP" != "" ] 
then
    echo $STARTUP > /startup/start.sh
fi
/bin/busybox httpd -f -p 80 -h /flash