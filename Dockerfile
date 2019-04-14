FROM lsiobase/python:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
    python2-dev && \
 echo "**** install app ****" && \
 git clone --depth 1 https://github.com/m0ngr31/kanzi.git /app/kanzi && \
 cd /app/kanzi && \
  pip install --no-cache-dir -U \
  python-Levenshtein && \
  pip install --no-cache-dir -U -r \
  requirements.txt && \
 echo "**** cleanup ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8000
VOLUME /config
