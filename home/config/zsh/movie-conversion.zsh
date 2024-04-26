
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

legacy-convert() {
    if [ ! -f "$1" ]; then
        echo "File $1 not found."
        return -1
    fi

    args=(-hide_banner)
    # args+=(-nostats)
    args+=(-loglevel info)
    args+=(-vsync 0)
    args+=(-hwaccel nvdec)
    #args+=(-hwaccel_output_format cuda)
    args+=(-i "$1")

    if [ -f "$2" ]; then
        args+=(-f srt)
        args+=(-i "$2")
    fi
    V_FORMAT=$(mediainfo --Inform="Video;%Format%" "$1")
    V_BIT_DEPTH=$(mediainfo --Inform="Video;%BitDepth%" "$1")
    V_REF_FRAMES=$(mediainfo --Inform="Video;%Format_Settings_RefFrames%")
    V_HEIGHT=$(mediainfo --Inform="Video;%Height%" "$1")
    A_FORMAT=$(mediainfo --Inform="Audio;%Format%" "$1")
    A_CHANNELS=$(mediainfo --Inform="Audio;%Channels%" "$1")

    # Use first video stream
    # Use first audio stream
    # Use all subtitle streams
    args+=(-map 0:v:0)
    args+=(-map 0:a:0)
    args+=(-map 0:s\?)
    args+=(-c:s mov_text)

    V_BIT_DEPTH="1"
    if [[ "$V_FORMAT" = "AVC" && "$V_BIT_DEPTH" = "8" ]]; then
        args+=(-c:v copy)
    else
        args+=(-c:v h264_nvenc)
        args+=(-profile:v high)
        args+=(-level:v 4.1)
        args+=(-pix_fmt yuv420p) # 8 bit pixel format
        # args+=(-b:v 0)
        #args+=(-maxrate 1M)
        #args+=(-bufsize 4M)
        args+=(-preset slow)
        args+=(-b_strategy 2) # 0 = fast but bad, 1 = fast and default, 2 = slow but more accurate
        args+=(-x264opts ref=4:bframes=16:b_strategy=2)
        args+=(-crf 24)
        #args+=(-t 120)
        args+=(-vf scale=-1:720)
        if [[ "$V_HEIGHT" -gt 1080 ]]; then
            args+=(-vf scale=-1:1080)
        fi
    fi

    if [ "$A_FORMAT" = "AAC" ]; then
        args+=(-c:a copy)
    else
        args+=(-c:a aac)
        args+=(-ac 2) # audio channels
    fi

    args+=(-movflags faststart)
    # args+=(-ss 00:37:10.000)
    # args+=(-t 180)
    # args+=(-y)
    args+=("${1%.*}.converted.mp4")

    echo "args: ${args[@]}"
    ffmpeg "${args[@]}"
}

convert() {
    V_HEIGHT=$(mediainfo --Inform="Video;%Height%" "$1")
    V_WIDTH=$(mediainfo --Inform="Video;%Width%" "$1")
    
	args=(-hide_banner)
	args+=(-benchmark)
    # args+=(-nostats)
    args+=(-loglevel info)
    args+=(-vsync 0)
	args+=(-hwaccel nvdec)
 #    args+=(-hwaccel cuda)
	# args+=(-hwaccel_output_format cuda)
    args+=(-i "$1")
    
	# Use first video stream
    # Use first audio stream
    # Use all subtitle streams
    # args+=(-map 0:v:0)
    # args+=(-map 0:a:0)
    # args+=(-map 0:s\?)
	args+=(-map 0)
    
	args+=(-c:s mov_text)

	args+=(-c:v h264_nvenc)
	args+=(-pix_fmt yuv420p)
	#
	# args+=(-pix_fmt yuv444p)
	# args+=(-pix_fmt cuda)
	# args+=(-vf scale=${V_WIDTH}:${V_HEIGHT})
	# args+=(-vf hwupload_cuda,scale_cuda=${V_WIDTH}:${V_HEIGHT})
	# args+=(-vf hwupload_cuda,scale_npp=w=${V_WIDTH}:h=${V_HEIGHT})
	# args+=(-vf scale_cuda=format=yuv420p)

	args+=(-c:a aac)
	args+=(-movflags faststart)

    args+=("${1%.*}.converted.mp4")

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
