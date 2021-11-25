#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if ! [ -x "$(command -v rust-analyzer)" ]; then
    printf"\n${RED}Rust analyzer binary not found\n"
fi

update_neovim() {
    printf "Updating.....\n"
    HTTPS_URL="https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz"
    CURL_CMD="curl -w http_code=%{http_code} -L"
    CURL_OUTPUT=`${CURL_CMD} ${HTTPS_URL} | gunzip -c - > ~/.local/bin/rust-analyzer`
    # HTTP_CODE=$(echo "${CURL_OUTPUT}" | sed -e 's/.*\http_code=//')
    ERROR_MESSAGE=$(echo "${CURL_OUTPUT}" | sed -e 's/http_code.*//')

    if [ $? -eq 0 ]; then
	chmod +x ~/.local/bin/rust-analyzer
	printf "${GREEN}rust-analyzer has been updated. \n"
    else
	printf "${RED}rust-analyzer has NOT been updated. ERROR: ${ERROR_MESSAGE}${NC}\n"
    fi

}

SHOW_PROMPT=1
while [ $SHOW_PROMPT -gt 0 ]; do
    read -p "Update Rustanalyzer version? [y/n]" yn
    case $yn in
	[Yy]* ) update_neovim; break;;
	[Nn]* ) echo "No!!"; exit;;
	* ) echo "Bitch say yes or no";;
    esac
done
