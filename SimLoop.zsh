#!/usr/bin/env zsh

# Description: Runs VideoConversionSim.py X times and writes down all of the
# interesting results into a CSV file.

# Usage: ./SimLoop.zsh
#        ./SimLoop.zsh output.csv

# Written by Göran Gustafsson (gustafsson.g at gmail.com).
# License: BSD 3-Clause.

runs=1000
separator=";"
sed_parse="sed 's/.*: //;s/ .*//'"

if [[ $# -eq 0 ]]; then
  csv_file="SimResults.csv"
elif [[ $# -eq 1 ]]; then
  csv_file="$1"
else
  echo "Usage: ${0:t} [FILENAME]..."
  exit
fi

echo "Writing down simulation results in file: $csv_file"
echo "Mean wait${separator}Longest wait${separator}Above max wait" >| $csv_file

for i in {1..$runs}; do
  echo -n $i
  output=$(./VideoConversionSim.py)
  mean=$(echo $output | grep "Mean waiting time" | eval $sed_parse)
  longest=$(echo $output | grep "Longest waiting time" | eval $sed_parse)
  above=$(echo $output | grep "Above max waiting time" | eval $sed_parse)
  echo "${mean}${separator}${longest}${separator}${above}" >>| $csv_file
  printf "\r\e[K"
done
