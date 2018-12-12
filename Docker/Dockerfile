FROM eosio/builder as builder

ARG eos_branch=release/1.5.x
ARG cdt_release=latest

# Make sure we have everything we need
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get -y install openssl ca-certificates build-essential libbz2-dev zlib1g-dev libssl-dev libgmp3-dev libicu-dev cmake bc jq curl wget net-tools unzip gnupg git 

# Get and build EOS
RUN git clone -b $eos_branch https://github.com/EOSIO/eos.git --recursive \
    && cd eos && echo "$branch:$(git rev-parse HEAD)" > /etc/eosio-version \
    && cmake -H. -B"/tmp/build" -GNinja -DCMAKE_BUILD_TYPE=Release -DWASM_ROOT=/opt/wasm -DCMAKE_CXX_COMPILER=clang++ \
       -DCMAKE_C_COMPILER=clang -DCMAKE_INSTALL_PREFIX=/tmp/build -DBUILD_MONGO_DB_PLUGIN=true -DCORE_SYMBOL_NAME=$symbol \
    && cmake 

# Get the CDT binaries
ADD downloadBinaries.sh /
RUN /downloadBinaries.sh $cdt_release

# Install the binaries
RUN for filename in $(ls *.deb); do /usr/bin/dpkg -i "$filename" && rm -f "$filename"; done

ENV EOSIO_ROOT=/opt/eosio
ENV LD_LIBRARY_PATH /usr/local/lib
ENV PATH /opt/eosio/bin:/opt/eosio.cdt/1.4.1/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
