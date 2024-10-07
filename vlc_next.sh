#!/bin/bash
shopt -s extglob

export __NV_PRIME_RENDER_OFFLOAD=1 
export __VK_LAYER_NV_optimus=NVIDIA_only 
export __GLX_VENDOR_LIBRARY_NAME=nvidia

# list of extensions for searching in current directory
extensions_video='avi|mp4|mkv|m4v|mov|mpg|mpeg|wmv|3gp'
extensions_audio='ogg|opus|flac|m4a|mp3|wav'
extensions="@(${extensions_video}|${extensions_audio})"

# kill other instances of vlc
killall vlc; sleep 0.1

# launch empty vlc if no argument provided
if [ -z "$1" ]; then
	vlc; exit
fi

# parse argument
filename=$(realpath -- "$1")
dirname=$(dirname "$filename")
basename=$(basename "$filename")

# list files with matching extension
OLDIFS="$IFS"
IFS='' list=$(ls "${dirname}"/*.${extensions} -1 2>/dev/null)
IFS="$OLDIFS"

# get position of filename in current directory
pos=$(echo "$list" | grep -n -F -- "${basename}" | cut -d: -f1)

# if the filename does not have one of the extension above, launch vlc with provided filename
if [ -z "$pos" ]; then
	vlc -- "${filename}"
	exit
fi

# change positions in playlist such as the first element is the opened file
n=$(echo "$list" | wc -l)
echo "$list" | tail -n$(($n-$pos+1)) >  /tmp/vlc.m3u
echo "$list" | head -n$(($pos-1))    >> /tmp/vlc.m3u

# launch playlist
IFS=$'\n'; read -d '' -r -a files < /tmp/vlc.m3u; vlc "${files[@]}"
