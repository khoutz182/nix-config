
capture() {
    args=(-hide_banner)
    args+=(-loglevel fatal)

    # video input
    VIDEO_DEVICE=$(v4l2-ctl --list-devices 2> /dev/null | grep "/dev/" | head -n 1 | xargs)
    args+=(-f v4l2)
    # args+=(-standard NTSC)
    args+=(-input_format mjpeg)
    args+=(-video_size 720x480)
    args+=(-thread_queue_size 512)
    args+=(-i $VIDEO_DEVICE)

    # audio input
    CARD_NUMBER=$(arecord -l | grep "AV TO USB2.0" | awk '{print $2}' | sed 's/[^0-9]*//g')
    SUBDEVICE_NUMBER=$(arecord -l | grep -A 2 "AV TO USB2.0" | grep "Subdevice" | grep -v "Subdevices" | awk '{print $NF}' | sed 's/[^0-9]*//g')
    args+=(-f alsa)
    args+=(-ac 1)
    args+=(-thread_queue_size 8192) # why so huge, i dunno...
    args+=(-i hw:$CARD_NUMBER,$SUBDEVICE_NUMBER)

    # output
    args+=(-vcodec h264_nvenc)
    args+=(-pix_fmt yuv420p)
    # args+=(-s 480x320)
    # args+=(-aspect 4:3)
    args+=(-crf 24)
    args+=(-bf 4)
    args+=(-preset fast)
    args+=(-c:a aac)
    args+=(-b:a 128k)
    args+=(-ac 1)
    args+=(-ar 44100)
    args+=(captured.mp4)

    # view
    args+=(-f mpegts)
    # args+=(-an)
    args+=(-s 360:288)
    args+=(pipe:1)

    echo "${args[@]}"

    ffmpeg "${args[@]}" | ffplay -autoexit -loglevel quiet -an -i -
    # ffmpeg "${args[@]}"
}

convert() {
	args=(-hide_banner)
	args+=(-benchmark)
    # args+=(-nostats)
    # args+=(-loglevel info)
    args+=(-i "$1")
    # Use first video stream
    # Use first audio stream
    # Use all subtitle streams
    # args+=(-map 0:v:0)
    # args+=(-map 0:a:0)
    # args+=(-map 0:s\?)
	args+=(-map 0:m:language:eng)
	args+=(-map 0:v:0)

	args+=(-c:v libx264)
	args+=(-crf 18)
	args+=(-preset slow)
	args+=(-vf format=yuv420p)
	args+=(-x264-params ref=4)
	args+=(-c:a aac)
	args+=(-c:s mov_text)
	args+=(-movflags faststart)

	if [ -f "${1%.*}.mp4" ]; then
		args+=("${1%.*}.conv.mp4")
	else
		args+=("${1%.*}.mp4")
	fi

	echo "args: ${args[@]}"
	ffmpeg "${args[@]}"
}

add-subs() {
    if [ ! -f "$1" ]; then
        echo "File $1 not found."
        return -1
    fi

    args=(-i "$1")

    if [ ! -f "$2" ]; then
        echo "File $2 not found."
        return -1
    fi

    args+=(-f srt)
    args+=(-i "$2")

    args+=(-c copy)
    args+=(-c:s mov_text)

    output_file="${1%.*}.subbed.${1##*.}"
    args+=("${output_file}")

    ffmpeg "${args[@]}"

    rm "$1"
    mv "${output_file}" "$1"
}

convert-all() {
    for f in *.$1; do
        [ -e "$f" ] || continue
        convert "$f"
    done
}
