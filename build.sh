#!/bin/bash

export LANG=zh_TW.UTF8
export REPO=https://github.com/e-Cheng/EmulationStation.git

if [[ -z "${LANG}" || -z "${REPO}" ]]; then
    echo "export LANG && export REPO"
else
    rm -rf ./emulationstation

    docker build -t="build-es" -f="./dockerfiles/emulationstation" . --build-arg LANG=${LANG} --build-arg REPO=${REPO}
    docker run -d --name run-build-es build-es
    docker cp run-build-es:/opt/retropie/supplementary/emulationstation .
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=build-es --format="{{.ID}}"))
    docker image rm build-es
fi