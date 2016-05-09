#!/bin/bash

function request {
 echo "0067want $(git rev-parse HEAD) thin-pack side-band-64k ofs-delta multi_ack_detailed";
 
 git upload-pack . <<< "0000" | tail -n +2 | head -n -1 | while read i; do
   if [[ $i != *"^"* ]]; then
     echo "0032want ${i:4:40}"
   fi
 done
 echo "00000008done"
}


wants=$(request)

echo "Git upload-pack request:"
echo "$wants"


GIT_TRACE=true GIT_TRACE_PACKET=true GIT_TRACE_PACK_ACCESS=true git upload-pack .git <<<$wants >/dev/null

