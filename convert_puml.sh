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

    while read filename; do
        new_filename=${filename/.puml/.png}
        if [[ ! out/${new_filename} -nt puml/${filename} ]]; then
            curl -o out/$new_filename --data-binary @puml/$filename \
                -H "Content-Type: text/plain; charset=utf-8" \
                http://localhost:${PORT_PLANTUML:-8080}/png

        else
            echo "skipped: ${filename}.puml is not updated"
        fi
    done < <(find puml -name "*.puml" -printf "%f\n" | sort)
)
