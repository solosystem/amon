#!/bin/bash 

wav=/home/amon/amon/calibrate.sh

echo "this is playback.sh"
echo "the time is `date`"

aplay $wav

echo "playback.sh finished."

exit 0
