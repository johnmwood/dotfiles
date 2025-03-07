#!/bin/bash
cp ~/.config/zed/settings.json .

function commitSettings () {
    git add . && git commit -m "update zed config"
}

git diff
while true; do
    read -r -p "Do you want to commit this change? " yn
    case $yn in
        [Yy]* ) commitSettings; break;;
        [Nn]* ) echo "no"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
