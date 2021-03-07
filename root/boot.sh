if [ "$STARTUP" != "" ] 
then
    echo $STARTUP > /startup/start.sh
fi
/bin/busybox httpd -f -p 80 -h /flash