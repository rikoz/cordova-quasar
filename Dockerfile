FROM thyrlian/android-sdk

LABEL maintainer="Rikome Erezi <rikome.erezi@gmail.com>"

# Install usbutils
RUN apt-get update && apt-get install -y usbutils

# Install specific SDK packages:
ARG PLATFORM_VERSION=29
ARG BUILD_TOOLS_VERSION=29.0.3

# "platform-tools", "build-tools", "platforms;android-{{ PLATFORM_VERSION }}", "licenses", "sources",
RUN sdkmanager "platform-tools" "build-tools;${BUILD_TOOLS_VERSION}" \
    "platforms;android-${PLATFORM_VERSION}" "sources;android-${PLATFORM_VERSION}" \
    "add-ons;addon-google_apis-google-24"

# Install node using nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

ENV NODE_VERSION 12.18.3
RUN /bin/bash -c "source /root/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION && node -v"

# Install yarn
RUN npm i -g --force yarn && yarn -v

# Add Cordova
RUN npm i -g --unsafe-perm cordova && cordova -v

# Add Quasar
RUN npm i -g @quasar/cli

# Make the 'app' folder the current working directory
WORKDIR /app