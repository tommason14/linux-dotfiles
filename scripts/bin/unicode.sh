#!/usr/bin/env bash

process_unicode_characters(){
  while read -r line 
  do 
    echo -e $line 
  done 
}

sed 's/U+/\\U/g' "$(dirname $0)/unicode.txt" | process_unicode_characters | dmenu -i -l 10 -p "Select char" | awk -F',' '{print $1}' | tr -d '\n' | xclip -selection clipboard
