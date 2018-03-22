#!/bin/bash

: ${INTERVAL:=300}

(( INTERVAL < 10 )) && INTERVAL=10

temp=$(mktemp --tmpdir=/var/tmp --suffix=.watch)
trap 'rm -f "$temp"' EXIT

fetch() {
    local url=${1:-ru.wttr.in}
    shift
    curl -o "$temp" -Ss "${url}" "$@"
    cat "$temp"
}

filter() {
    grep -v "Попробуйте" |
    grep -v "новые фичи"
}

adjust() { # to interval
    local -i STW=0
    local -i MTW=$(( INTERVAL / 60 - 1 ))

    while sleep 1; do
        STW=$(( (`date '+1%S'` - 100) % INTERVAL ))
        echo -ne "> ${MTW}m ${STW}s /${INTERVAL} ...\\r"
        if [ ${STW} -eq 0 ]; then
            [ ${MTW} -eq 0 ] && break
            (( MTW > 0 )) && let MTW-=1
        fi
    done
}

command=${1:-fetch} ; shift

while clear; do
    date '+%F %T %z'
    "$command" "$@" | filter
    adjust
done

# EOF #
