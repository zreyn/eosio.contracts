#!/bin/bash

Get EOS release by tag
if [ "$1" = "latest" ]; then
	eos_url=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4 | grep '18.04')
	eos_filename=$(echo "$eos_url" | awk -F "/" '{print $NF}')
else
    eos_url=$(curl -s https://api.github.com/repos/EOSIO/eos/releases/tags/$1 | grep "browser_download_url.*deb" | cut -d '"' -f 4 | grep '18.04')
	eos_filename=$(echo "$eos_url" | awk -F "/" '{print $NF}')
fi

# Get EOS release by tag
if [ "$2" = "latest" ]; then
	cdt_url=$(curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
	cdt_filename=$(echo "$cdt_url" | awk -F "/" '{print $NF}')
else
    cdt_url=$(curl -s https://api.github.com/repos/EOSIO/eosio.cdt/releases/tags/$2 | grep "browser_download_url.*deb" | cut -d '"' -f 4)
	cdt_filename=$(echo "$cdt_url" | awk -F "/" '{print $NF}')
fi

# Make sure we could get both
if [ -z "$eos_filename" ] || [ -z "$cdt_filename" ]; then
    if [ -z "$eos_filename" ]; then
        echo "Either $1 is not a valid release for eos, or there is not a published .deb package for the release."
    else 
        echo "Either $2 is not a valid release for eosio.cdt, or there is not a published .deb package for the release."
    fi
  exit 1
fi

# Download
wget $eos_url && wget $cdt_url