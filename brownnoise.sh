#!/bin/bash

rm /home/gemmstone/clones/pomodor/stop
# Set default values for urls.txt and duration.txt if they do not exist
if [[ ! -f /home/gemmstone/clones/pomodor/urls.txt ]]; then
    echo "https://www.youtube.com/watch?v=lTRiuFIWV54" > urls.txt
    echo "https://www.youtube.com/watch?v=_ITiwPMUzho" >> urls.txt
fi

if [[ ! -f /home/gemmstone/clones/pomodor/duration.txt ]]; then
    echo "25" > /home/gemmstone/clones/pomodor/duration.txt
fi

# Read a list of YouTube livestream URLs from a file
urls=($(cat urls.txt))

# Download each video if it hasn't already been downloaded
for url in "${urls[@]}"; do
    # Get the ID of the video
    video_id=$(yt-dlp --get-id "$url")

    # Check if the audio has already been downloaded
    if [[ ! -f "$video_id.m4a" ]]; then
        # Download the audio stream only in m4a format
        yt-dlp -f m4a -o "$video_id.m4a" "$url"
    fi
done

# Get the duration to play the audio stream, in minutes
duration=$(cat /home/gemmstone/clones/pomodor/duration.txt)

# Select a random video to play
audio_files=(/home/gemmstone/clones/pomodor/*.m4a)
if [[ "${#audio_files[@]}" -eq 0 ]]; then
    echo "No audio files found"
    exit 1
fi
audio_file=${audio_files[$RANDOM % ${#audio_files[@]}]}

# Get the duration of the audio stream
audio_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$audio_file")

# Calculate the maximum start time so the audio stream plays for the whole duration
max_start_time=$(echo "$audio_duration - $duration * 60" | bc)

# Generate a random start time in seconds
start_time=$(printf "%.0f" $(shuf -i 0-${max_start_time%.*} -n 1))

# Play the audio stream in mplayer starting from the random start time
notify-send "Playing focus music for $duration minutes" -a Fokus
mplayer "$audio_file" -ss "$start_time" -endpos "$duration:00" & pid=$!

# Get the full path to the stop file
stop_file="$(dirname "$0")/stop"

# Wait for the duration or for a stop signal
for ((i = 0; i < $duration * 60; i++)); do
    if [[ -f "$stop_file" ]]; then
        rm /home/gemmstone/clones/pomodor/stop
        break
    fi
    sleep 1
done

# Stop the mplayer process
kill $pid
