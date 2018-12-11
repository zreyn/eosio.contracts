FROM ubuntu:18.04

# Arguments that may be overridden by the user
ARG eos_release=latest
ARG cdt_release=latest

# Install required packages
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates build-essential libbz2-dev zlib1g-dev libssl-dev libgmp3-dev libicu-dev cmake bc jq curl wget net-tools unzip gnupg git && \
rm -rf /var/lib/apt/lists/*

# Get the EOS and CDT binaries
ADD downloadBinaries.sh /
RUN /downloadBinaries.sh $eos_release $cdt_release
ADD *.deb /

# install the binaries
RUN for filename in $(ls *.deb); do /usr/bin/dpkg -i "$filename" && rm -f "$filename"; done

# setup the env
ENV EOSIO_ROOT=/usr/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/lib
ENV PATH /usr/opt/eosio/bin:/usr/opt/eosio.cdt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

USER root

# git clone https://github.com/EOSIO/eosio.contracts.git
# cd eosio.contracts && ./build.sh