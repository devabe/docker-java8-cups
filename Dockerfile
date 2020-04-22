#FROM re6exp/debian-jessie-oracle-jdk-8
FROM hanazuki/cups

MAINTAINER Abe <contact@tafatek.com>

# ---------
# prepare folders
# ---------
RUN \
  mkdir /printingservice && \
  mkdir /printingservice/database && \
  mkdir /scripts

# ---------
# MULTIVERSE
# ---------
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common curl && \
    apt-add-repository multiverse && \
    apt-get update

# ---------
#Language FR
# ---------
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y locales
 
## Set LOCALE to UTF8
RUN echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen fr_FR.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8

# ---------
# MS CORE FONTS
# ---------
# from http://askubuntu.com/a/25614
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y --no-install-recommends fontconfig ttf-mscorefonts-installer
RUN fc-cache -f -v

# ---------
# Install JDK8 and Copy ms fonts to jvm
# ---------
RUN apt-get install -y openjdk-8-jdk
#    cp -r /usr/share/fonts/truetype/msttcorefonts /usr/lib/jvm/java-8-openjdk-amd64/lib/fonts && \
#    dpkg-reconfigure fontconfig

RUN apt-get install -y cups-bsd
