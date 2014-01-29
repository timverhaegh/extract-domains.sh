#!/bin/bash

fileInput="/dev/stdin";
fileOutput="/dev/stdout";
sort_reverse="-r";


while getopts ':ci:o:r' OPTION ; do
  case "$OPTION" in
    c)  uniq_count="-c";;
    i)  fileInput="${OPTARG}";;
    o)  fileOutput="${OPTARG}";;
    r)  sort_reverse="";;
    *)  ;;
  esac
done


cat ${fileInput} | \
 sed -e 's#.*http://##' -e 's#[[:blank:]].*##' | \
  sed -e 's#\?##' -e 's#:[0-9][0-9]*##' -e 's#{\|\;].*##' | \
   sed -e 's#/#§#1' -e 's#§.*##' | \
    grep '\.' | \
     sed -e 's#^www\.##' | \
      uniq ${uniq_count} | \
       sort ${sort_reverse} \
        > ${fileOutput}
