#!/bin/bash
cp ~/.config/zed/settings.json .

git diff
while true; do
    read -r -p "Do you want to commit this change? " yn
    case $yn in
        [Yy]* ) git add . && git commit -m "update zed config"; break;;
        [Nn]* ) echo "no"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
