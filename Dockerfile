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

# Install ipaexfont
RUN wget -O IPAfont00303.zip http://ipafont.ipa.go.jp/old/ipafont/IPAfont00303.php
RUN unzip IPAfont00303.zip
RUN mv IPAfont00303 /usr/share/fonts/truetype/
RUN fc-cache

# Install packages
RUN Rscript -e "install.packages(c('githubinstall', 'ranger', 'revealjs','DT','Nippon','rstan'))"

CMD ["/init"]
