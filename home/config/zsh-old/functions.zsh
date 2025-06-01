reboot_to_windows() {
    windows_title=$(sudo grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "${windows_title}" && sudo reboot
}

alias r2w='reboot_to_windows'

gmv() {
    [ -z "$1" ] && echo "Parameter should be new branch name" && return
    previous_branch=$(git_current_branch)
    remote=$(git remote)
    git branch -m $1
    git push $remote :$previous_branch
    git push $remote -u $1
}

bbdp() {
	origin="$(pwd)"
	cd /home/kevin/src/unifyd/backend
	mvn -e -B package -DskipTests
	docker build -f .github/Dockerfile -t backend:latest .
	docker tag g backend:latest 866298170914.dkr.ecr.us-east-1.amazonaws.com/backend:latest
	docker push 866298170914.dkr.ecr.us-east-1.amazonaws.com/backend:latest
	cd "$origin"
}

jelly-cp() {
	DIRECTORY="${2:-movies}"
	echo "sending to /media/${DIRECTORY}"
	POD=$(kubectl get pods -n app-jellyfin --no-headers -o custom-columns=":metadata.name")
	kubectl cp $1 app-jellyfin/${POD}:/media/${DIRECTORY}
}

jq-to-less() {
	jq -C ${1} | less -R
}

toggle-headphones() {
	SINK=$(pactl --format json list short sinks | jq -r '.[].name' | rg -i yeti)

	pactl set-sink-mute $SINK toggle
}

alias jql='jq-to-less'

keep-presence() {
	DEGREES=0
	while :; do
		xdotool mousemove_relative -p $DEGREES 100
		[[ $DEGREES -lt 180 ]] && DEGREES=180 || DEGREES=0
		sleep 1m
	done
}

dropdown() {
	window=$(yabai -m query --windows | jq --arg app $1 '.[] | select(.app==$app)')
	visible=$(echo $window | jq '."is-visible"')
	id=$(echo $window | jq '.id')
	hidden_space=2
	echo "Visible = $visible"
	echo "ID = $id"

	if [ -z "$visible" ]; then
		echo "conducting magic"
		# wtf is this magic
		osascript \
			-e "on run (argv)" \
			-e "tell application (item 1 of argv) to activate" \
			-e "end" \
			-- "$1"
	elif [ "$visible" = true ]; then
		echo "moving to the nether realm"
		yabai -m window $id --space $hidden_space
	else
		echo "yeah whatever"
		yabai -m window $id --space mouse && yabai -m window --focus $id
	fi
}
