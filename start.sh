#!/bin/bash

# Function to check if a package is installed
package_installed() {
    dpkg -s $1 &> /dev/null
}

# Check if the packages are installed
if package_installed htop && \
   package_installed neofetch && \
   package_installed tmate && \
   package_installed speedtest-cli && \
   package_installed nodejs && \
   package_installed npm && \
   package_installed python3-pip && \
   package_installed openjdk-17-jre-headless; then

    # If everything is installed, run gotty
    gotty --credential root:adminroot /bin/bash

else
    # Install required packages in the user's home directory
    mkdir -p $HOME/packages
    cd $HOME/packages

    # Download and install Node.js and npm
    wget -O nodejs.deb https://deb.nodesource.com/node_14.x/pool/main/n/nodejs/nodejs_14.18.3-deb-1nodesource1_amd64.deb
    dpkg -x nodejs.deb .
    export PATH=$HOME/packages/usr/bin:$PATH

    # Install other required packages
    npm install htop neofetch tmate speedtest-cli -g --prefix=$HOME/packages
    pip3 install --user gotty

    # Run Gotty
    $HOME/packages/bin/gotty --credential root:adminroot /bin/bash
fi
