#!/bin/bash

#Constants
CUR_DIR=$(pwd)
commit_msg=()

#jq check
is_jq=$(which jq)
if [[ -z $is_jq ]]; then
    echo "please install jq"
    if [ $(command -v apt) ]; then
        echo "sudo apt install jq"
    elif [ $(command -v pacman) ]; then
        echo "sudo pacman -S jq"
    fi
    exit 0
fi

function fetchPrebuilts() {

    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
        gh_json=$(curl -s "$2")
        file_last_update=$(echo $gh_json | jq -r '.assets[0].updated_at' | cut -d "T" -f1 | xargs -I {} date -d {} +"%Y%m%d")
        apk_down_url=$(echo $gh_json | jq -r '.assets[0].browser_download_url')
        tag=$(echo $gh_json | jq -r .tag_name)
        body=$(echo $gh_json | jq -r .body)

        echo "Grabbing the latest version of ${1}"
        mkdir -p "${CUR_DIR}/${1}"
        wget -q --show-progress -O "${CUR_DIR}/${1}/${1}.apk" $apk_down_url
        echo -e "Fetch Tag: $tag\n$body" > "${CUR_DIR}/${1}/build.md"

        commit_msg+=("- ${1}: Updated to latest build [$tag]\n")

        echo "${1} updated to latest version"
    else
        echo "Looks like theres no internet connection"
        if [[ -f "${CUR_DIR}/${1}/${1}.apk" ]]; then
            echo "An old version of ${1} exists, using it for now."
        else
            echo "Nothing found! ${1} won't be available in this build!"
        fi
    fi
}

# parameters
# 1 - App name # 2 - App apk url
fetchPrebuilts DuckDuckGo https://api.github.com/repos/duckduckgo/Android/releases/latest
fetchPrebuilts Camera https://api.github.com/repos/GrapheneOS/Camera/releases/latest

# git commit stage
if [ ${#commit_msg[@]} -ne 0 ]; then
    cd $CUR_DIR
    git add .

    git commit -m "Prebuilts: Update [check description]" -m "$(echo -e ${commit_msg[*]})"
    echo "Committed locally, push to git!"
fi
