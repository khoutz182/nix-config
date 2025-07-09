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
	# args+=(-crf 18)
	# args+=(-preset slow)
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

convert-all() {
    for f in *.$1; do
        [ -e "$f" ] || continue
        convert "$f"
    done
}
