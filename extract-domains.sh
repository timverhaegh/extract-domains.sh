#!/bin/bash

while getopts ':cf:r' OPTION ; do
  case "$OPTION" in
    c)   uniq_count="-c";;
    f)   fileToScan="${OPTARG}";;
    r)   sort_reverse="-r";;
    *)   ;;
  esac
done

echo "---$fileToScan---"

cat $fileToScan | \
 sed -e 's#.*http://##' -e 's#[[:blank:]].*##' | \
  sed -e 's#\?##' -e 's#:[0-9][0-9]*##' -e 's#{\|\;].*##' | \
   sed -e 's#/#§#1' -e 's#§.*##' | \
    grep '\.' | \
     sed -e 's#^www\.##' | \
      sort $sort_reverse | \
       uniq $uniq_count
