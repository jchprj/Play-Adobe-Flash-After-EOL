# Play Adobe Flash After EOL

The base image is the powerful [linuxserver/docker-baseimage-guacgui](https://github.com/linuxserver/docker-baseimage-guacgui) which interested me to create a container for old Flash. Without the ability to access an inner browser or other GUI application directly in browser, it is not so attractive to do these work.


![Screenshot](screenshot.png)  
Firefox running in Docker accessible in Chrome

## Usage

A simple command is:
```
docker run -p 8080:8080 --name play-adobe-flash-after-eol jchprj/play-adobe-flash-after-eol
```

There are some customizable settings:

### Remote desktop

Just expose 3389 port

### Run Chrome/Firefox/standalone Flash player

Use environment variable: `STARTUP`, the value is a whole command, for example:
```
docker run -e "STARTUP=firefox https://localhost/index.html" -p 8080:8080 --name play-adobe-flash-after-eol jchprj/play-adobe-flash-after-eol
```

The value of `STARTUP` could be one of the following commands(if need open any URL by default, just add the URL to the end of the line):
```
flashplayer
flashplayerdebugger
google-chrome --no-sandbox
```

Another way is to mount the `/startup` folder, and provide a different `start.sh`, it will be executed at the beginning.

### HTTP server

There is a light HTTP server running in the container and serve `/flash` folder. Just mount this folder could run any contents outside the container. 

The purpose of the HTTP server is standalone Flash player disabled loading local content by default and hard to be set in advance using Docker, so a http server is running in the container to support open content in `http://localhost`


## Other

If you want to compile `.swf` from source, another Docker image([jchprj/docker-flex-4.6-sdk-ant](https://hub.docker.com/r/jchprj/docker-flex-4.6-sdk-ant)) I created years ago could be used, for example:
```
docker run -v ${PWD}:/flash -it --rm jchprj/docker-flex-4.6-sdk-ant mxmlc /flash/HelloWorld.as
```