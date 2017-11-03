#!/bin/bash
if [ $# -lt 2 ]; then
  echo "USAGE:  UnityFilesSynch.sh from_directory to_directory"
  exit 1
fi

fromDir="$1"
toDir="$2"

files=$toDir/*.cs.meta
for filename in $files; do
	[ -e "$filename" ] || continue
	filenamebase=${filename##*/}
	filenamebase=`echo $filenamebase | sed 's/.meta$//'`
	if [ ! -f "$fromDir/$filenamebase" ]; then
    	rm $filename
    fi
done

files=$toDir/*.cs
for filename in $files; do
	[ -e "$filename" ] || continue
	filenamebase=${filename##*/}
	if [ ! -f "$fromDir/$filenamebase" ]; then
    	rm $filename
    fi
done

cp $fromDir/*.cs $toDir