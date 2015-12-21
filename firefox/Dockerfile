FROM debian:sid
MAINTAINER T <t@stromberg.org>

RUN apt-get update \
  && apt-get install -y bzip2 iceweasel libgtk-3-0 \
  && rm -rf /var/lib/apt/lists/* /src/*.deb

# Should match the "audio" group in the host.
RUN mkdir -p /usr/local/firefox
ADD https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-46.0a1.en-US.linux-x86_64.tar.bz2 /tmp/firefox.tar.bz2
RUN md5sum /tmp/firefox.tar.bz2 | grep d2cd574fb4a0aa48145b316915520f9b
RUN tar -C /usr/local -jxvf /tmp/firefox.tar.bz2
RUN chmod -R o+rx /usr/local

RUN groupmod -g 92 audio
RUN useradd -ms /bin/sh -G audio firefox

ENV HOME /home/firefox
USER firefox

COPY local.conf /etc/fonts/local.conf

# Autorun firefox
ENTRYPOINT [ "/usr/local/firefox/firefox" ]
