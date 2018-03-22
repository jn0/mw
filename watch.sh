#!/bin/bash

INTERVAL=60

fetch() {
    local url=${1:-wttr.in}
    shift
    curl -H "Accept-Language: ru" -Ss "${url}" "$@"
}

# adjust to :00 secs
while :; do
    TTW=$(( `date '+1%S'` - 100 ))
    echo -ne "${TTW} ...\\r"
    [ ${TTW} -eq 0 ] && break
    sleep 0.5
done

command=${1:-fetch} ; shift

while clear; do
    date '+%F %T %z'
    "$command" "$@"
    sleep ${INTERVAL:-5}
done | grep -v "Попробуйте" | grep -v "новые фичи"

# EOF #
