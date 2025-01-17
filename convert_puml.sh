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

    # ext should be png, svg, or pdf
    ext=${1:-png}
    if [[ $ext != "png" && $ext != "svg" && $ext != "pdf" ]]; then
        echo "Usage: $0 [png|svg|pdf]"
        exit 1
    fi

    while read filename; do
        output_dir=out/$ext
        mkdir -p $output_dir
        new_filepath=${output_dir}/${filename/.puml/.$ext}

        if [[ ! ${new_filepath} -nt puml/${filename} ]]; then
            curl -o $new_filepath --data-binary @puml/$filename \
                -H "Content-Type: text/plain; charset=utf-8" \
                http://localhost:${PORT_PLANTUML:-8080}/$ext

        else
            echo "skipped: ${filename}.puml is not updated"
        fi
    done < <(find puml -name "*.puml" -printf "%f\n" | sort)
)
