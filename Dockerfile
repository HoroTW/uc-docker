# Base is Ubuntu 22.04
FROM debian:bullseye

# VNC server port
EXPOSE 5900

# set the timezone so that tzdata doesn't ask for it
ENV DEBIAN_FRONTEND=noninteractive
# ENV TZ=Europe/Berlin
# RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime


# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    xvfb \
    fluxbox \
    x11vnc \
    x11-apps \
    sudo \
    wget \
    curl \
    htop

# Create a new virtual environment
RUN python3 -m venv /opt/venv

# Activate the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies and update pip
RUN pip install --upgrade pip
RUN pip install ipython
RUN pip install undetected-chromedriver

# add google chrome repo and accept the key + install chrome
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-chrome.gpg
RUN apt-get update && apt-get install google-chrome-stable=112.* -y

# Copy the entrypoint.sh to the container into the root directory
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
