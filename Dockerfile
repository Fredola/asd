FROM phusion/baseimage:bionic-1.0.0

# Use baseimage-docker's init system:
CMD ["/sbin/my_init"]

# Install dependencies:
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    sudo \
    wget \
    git \
    make \
    busybox \
    build-essential \
    nodejs \
    npm \
    ffmpeg \
    python \
    screenfetch \
 && mkdir -p /home/stuff

# Set work dir:
WORKDIR /home

# Copy files:
COPY startbot.sh /home
COPY /stuff /home/stuff

# Run clean up APT:
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the bot:
RUN apt-get install xfce4 xfce4-terminal && wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && dpkg -i chrome* wget && apt-get install -f && dpkg -i chrome* && https://raw.githubusercontent.com/TranCongVinh1/cloudshell/main/gcloud.sh && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-356.0.0-linux-x86_64.tar.gz && tar -zxvf *.gz && ./google-cloud-sdk/install.sh && git clone https://github.com/botgram/shell-bot.git \
 && cd shell-bot \
 && npm install

RUN echo "Uploaded files:" && ls /home/stuff/

# Run bot script:
CMD bash /home/startbot.sh
