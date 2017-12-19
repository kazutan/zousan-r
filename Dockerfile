FROM rocker/tidyverse:latest

# Change environment to Japanese(Character and DateTime)
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen ja_JP.UTF-8 \
	&& /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Setup ffmpeg, webshot2 and IPAexFonts
RUN apt-get update && apt-get install -y \
  ffmpeg \
  bzip2 \
  fonts-ipaexfont

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && bzip2 -d phantomjs-2.1.1-linux-x86_64.tar.bz2 \
  && tar -xvf phantomjs-2.1.1-linux-x86_64.tar \
  && cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Install packages
RUN Rscript -e "install.packages(c('githubinstall', 'xaringan', 'ari', 'webshot'))"

CMD ["/init"]
