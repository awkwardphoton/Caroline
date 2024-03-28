#!/bin/bash

# URL of the webpage to fetch
url="https://www.bbc.co.uk/programmes/p002vsn1/episodes/player"

# Fetch webpage content and extract PID
content=$(curl -s "$url")
pid=$(echo "$content" | grep -oP 'data-pid="\K[^"]+' | head -n 1)

# Fetch webpage content for specific PID and extract download URL
episode_url="https://www.bbc.co.uk/programmes/$pid"
episode_content=$(curl -s "$episode_url")
download_url=$(echo "$episode_content" | grep -oP 'href="//open.live.bbc.co.uk/mediaselector/[^"]+\.mp3"' | head -n 1 | sed 's/href="//')

# Download the mp3 file
wget -O "BBC_News_Summary.mp3" "https:$download_url"

echo "Download complete"
