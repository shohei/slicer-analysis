#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: ./convert2json.sh filename" 1>&2
  exit 1
fi

filename=$1
basename=${filename##*/}

sed -e '/^#/d' ${filename} > convert.json
perl -pe 's/\r//g' convert.json > convert2.json
sed -i -e 's/;.*//g' convert2.json 
sed -i -e 's/\(.*\) = \([0-9,-.]*\)$/"\1" : \2/g' convert2.json 
sed -i -e 's/\(.*\) = \(.*\)/"\1" : "\2"/g' convert2.json 
sed -i -e 's/\(.*\) : $/\1 : ""/g' convert2.json 
sed -i -e 's/$/,/g' convert2.json
sed -i -e "1s/^/[{/" convert2.json 
sed -i -e '$s/,$/}]/' convert2.json 
sed -i -e 's/\n//g' convert2.json
perl -pe 's/\n/ /g' convert2.json > ${basename}.json
rm convert.json
rm convert2.json
rm convert2.json-e
