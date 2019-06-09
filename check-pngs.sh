#!/usr/local/bin/bash

pngs=$(ls *.png | grep -v octicons | grep -v icon.png)
for png in $pngs; do
  grep -i -q $(basename -s .png $png) info.plist || echo $png
done
