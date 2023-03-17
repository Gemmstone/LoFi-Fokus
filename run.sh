#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

rm $SCRIPT_DIR/stop
if [[ ! -f $SCRIPT_DIR/urls.txt ]]; then
    echo "https://www.youtube.com/watch?v=dQw4w9WgXcQ" > urls.txt
    echo "https://www.youtube.com/watch?v=dQw4w9WgXcQ" >> urls.txt
fi

if [[ ! -f $SCRIPT_DIR/duration.txt ]]; then
    echo "25" > $SCRIPT_DIR/duration.txt
fi

urls=($(cat $SCRIPT_DIR/urls.txt))
for url in "${urls[@]}"; do
    video_id=$(yt-dlp --get-id "$url")

    if [[ ! -f "$SCRIPT_DIR/$video_id.m4a" ]]; then
        yt-dlp -f m4a -o "$SCRIPT_DIR/$video_id.m4a" "$url"
    fi
done

duration=$(cat $SCRIPT_DIR/duration.txt)

audio_files=($SCRIPT_DIR/*.m4a)
if [[ "${#audio_files[@]}" -eq 0 ]]; then
    echo "No audio files found"
    exit 1
fi
audio_file=${audio_files[$RANDOM % ${#audio_files[@]}]}

audio_duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$audio_file")

max_start_time=$(echo "$audio_duration - $duration * 60" | bc)

start_time=$(printf "%.0f" $(shuf -i 0-${max_start_time%.*} -n 1))

notify-send "Playing focus music for $duration minutes" -a Fokus
mplayer "$audio_file" -ss "$start_time" -endpos "$duration:00" & pid=$!

stop_file="$(dirname "$0")/stop"

for ((i = 0; i < $duration * 60; i++)); do
    if [[ -f "$stop_file" ]]; then
        rm $SCRIPT_DIR/stop
        break
    fi
    sleep 1
done

kill $pid
