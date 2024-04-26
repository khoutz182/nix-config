# start ssh-agent but only once
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent >! ~/.ssh-agent-thing
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<~/.ssh-agent-thing)" > /dev/null 2>&1
fi

for file in ~/.ssh/*
do
    PRIVATE=$(file $file | grep private)
    # second line in a password protected private key has "ENCRYPTED" at the end
    ENCRYPTED=$(sed '2q;d' $file | grep ENCRYPTED)
    if [ ! -z "$PRIVATE" ] && [ -z "$ENCRYPTED" ]; then
        ssh-add "${file}" > /dev/null 2>&1
    fi
done
