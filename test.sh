#!/bin/bash

# git upload-pack . <$(echo 0000) >heads

echo >> wants
while read i; do
  l="0032want $(cut -c 5-40 - <<<$i)"
  echo $l >> wants  
  echo $l
done < heads


# cat request | git upload-pack . 