FROM debian:stable

## For geckodriver installation: curl/wget/libgconf/unzip
RUN apt-get update -y && apt-get install -y wget curl unzip libgconf-2-4 chromium-driver

## For project usage: python3/python3-pip/chromium/xvfb
## Installing Firefox to Debian Stretch https://unix.stackexchange.com/a/406554/169768
RUN sh -c 'echo "APT::Default-Release "stable";" >> /etc/apt/apt.conf'
RUN sh -c 'echo "deb http://ftp.hr.debian.org/debian sid main contrib non-free" >> /etc/apt/sources.list'
RUN apt-get update -y && apt-get install -yt sid firefox
RUN apt-get update -y && apt-get install -y xvfb python3 python3-pip

# Create directory for project name (ensure it does not conflict with default debian /opt/ directories).
RUN mkdir -p /opt/app
WORKDIR /opt/app


## Install the deps for selenium
COPY requirements.txt .
RUN pip3 install -r requirements.txt


COPY app .

## Install the deps for selenium
## We will have overwritten in the
## prior COPY command
RUN pip3 install -r requirements.txt

# Copy the runner script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Copy the selenium script
COPY selenium_example.py /opt/app/

ENV DISPLAY=:99
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null


# Bash cmd
CMD [ "/run.sh" ]
