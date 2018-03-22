#!/bin/bash

: ${INTERVAL:=60}

temp=$(mktemp --tmpdir=/var/tmp --suffix=.watch)
trap 'rm -f "$temp"' EXIT

fetch() {
    local url=${1:-wttr.in}
    shift
    curl -o "$temp" -H "Accept-Language: ru" -Ss "${url}" "$@"
    cat "$temp"
}

filter() {
    grep -v "Попробуйте" |
    grep -v "новые фичи"
}

adjust() { # to interval
    local -i TTW=0

    while :; do
        TTW=$(( (`date '+1%S'` - 100) % INTERVAL ))
        echo -ne "${TTW}/${INTERVAL} ...\\r"
        [ ${TTW} -eq 0 ] && break
        sleep 0.5
    done
}

command=${1:-fetch} ; shift

while clear; do
    date '+%F %T %z'
    "$command" "$@" | filter
    sleep 0.5
    adjust
done

# EOF #
