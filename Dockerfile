FROM lsiobase/guacgui

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME ALL

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720
ENV DISPLAY=:1
ENV HOME=/config


#########################################
##           INSTALL SOFTWARE          ##
#########################################

RUN \
 echo "**** install deps ****" && \
 apt-get update && \
 apt-get install -qy --no-install-recommends \
	x11-apps \
	wget \
	unzip \
	libcurl3 \
	libgtk2.0-0 \
	libdbus-glib-1.2 \
    busybox \
	fonts-wqy-microhei 
RUN apt-get update

# add local files
# COPY chrome64_53.0.2785.116.deb /tmp
# COPY firefox-42.0.tar.bz2 /tmp
# COPY flash_player_32_sa_linux_debug.x86_64.tar.gz /tmp
# COPY flash_player_32_sa_linux.x86_64.tar.gz /tmp
# COPY fp_32.0.0.371_archive.zip /tmp
ADD https://www.slimjetbrowser.com/chrome/lnx/chrome64_53.0.2785.116.deb /tmp
ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/42.0/linux-x86_64/en-US/firefox-42.0.tar.bz2 /tmp
ADD https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux_debug.x86_64.tar.gz /tmp
ADD https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux.x86_64.tar.gz /tmp
ADD https://web.archive.org/web/20200618035158/https://fpdownload.macromedia.com/pub/flashplayer/installers/archive/fp_32.0.0.371_archive.zip /tmp

RUN ls -l /tmp && mkdir /player && \
	tar -C /player -zxvf /tmp/flash_player_32_sa_linux.x86_64.tar.gz flashplayer && \
	tar -C /player -zxvf /tmp/flash_player_32_sa_linux_debug.x86_64.tar.gz flashplayerdebugger
RUN unzip -j -d /tmp /tmp/fp_32.0.0.371_archive.zip 32_0_r0_371_debug/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz && \
	tar -C / -zxvf /tmp/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz usr && \
	mkdir -p /usr/lib/mozilla/plugins && \
	tar -C /usr/lib/mozilla/plugins -zxvf /tmp/flashplayer32_0r0_371_linux_debug.x86_64.tar.gz libflashplayer.so
RUN tar -xf /tmp/firefox-42.0.tar.bz2
RUN apt-get -yy install /tmp/chrome64_53.0.2785.116.deb


#########################################
##               CLEAN UP              ##
#########################################

RUN echo "**** clean up ****" && \
 	rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

COPY /root /
CMD ["sh", "/boot.sh"]

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whater volumes and ports you want exposed here:
# ports and volumes
EXPOSE 3389
VOLUME /config