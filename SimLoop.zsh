#!/usr/bin/env zsh

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

# Copyright (c) 2014, Göran Gustafsson. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#
#  Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

runs=1000
sed_parse="sed 's/.*: //;s/ .*//'"
separator=;

if [[ $# -eq 0 ]]; then
  csv_file="SimResults.csv"
elif [[ $# -eq 1 ]]; then
  csv_file="$1"
else
  echo "Usage: ${0:t} [FILENAME]..."
  exit
fi

echo "Writing down simulation results in file: $csv_file"
echo "Mean wait,Longest wait,Above max wait" >| $csv_file

for i in {1..$runs}; do
  echo -n $i
  output=$(./VideoConversionSim.py)
  mean=$(echo $output | grep "Mean waiting time" | eval $sed_parse)
  longest=$(echo $output | grep "Longest waiting time" | eval $sed_parse)
  above=$(echo $output | grep "Above max waiting time" | eval $sed_parse)
  echo "${mean}${separator}${longest}${separator}${above}" >>| $csv_file
  printf "\r\e[K"
done
