#!/bin/sh
set -e

file='/isp/'$(date +%Y-%m-%d)'.csv'
if [ -f "$file" ]; then
    speedtest-cli --csv >> $file
else
    touch $file
    chmod 777 $file
    speedtest-cli --csv-header >> $file
    speedtest-cli --csv >> $file
fi

exit;