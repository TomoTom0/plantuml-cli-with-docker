#!/bin/bash

(
    dirpath=$(
        cd $(dirname $0)
        pwd
    )
    echo $dirpath
    cd $dirpath
    if [[ -f .env ]]; then
        source .env
    fi

    while read line; do
        new_file=${line/.puml/.png}
        curl -o out/$new_file --data-binary @puml/$line \
            -H "Content-Type: text/plain; charset=utf-8" \
            http://localhost:${PORT_PLANTUML:-8080}/png
    done < <(find puml -name "*.puml" -printf "%f\n")
)
