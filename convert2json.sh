#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: ./convert2json.sh filename" 1>&2
  exit 1
fi

filename=$1
basename=${filename##*/}

sed -e '/^#/d' ${filename} > convert.json
sed -i -e 's/;.*//g' convert.json 
sed -i -e 's/\(.*\) = \([0-9,-.]*\)$/"\1" : \2/g' convert.json 
sed -i -e 's/\(.*\) = \(.*\)/"\1" : "\2"/g' convert.json 
sed -i -e 's/\(.*\) : $/\1 : ""/g' convert.json 
sed -i -e 's/$/,/g' convert.json
sed -i -e "1s/^/[{/" convert.json 
sed -i -e '$s/,$/}]/' convert.json 
sed -i -e 's/\n//g' convert.json
perl -pe 's/\n/ /g' convert.json > ${basename}.json
rm convert.json
