#!/usr/bin/env zsh

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

# Description: The script i used to automatically run SimResultsGroup.rb on all
# of my logged data files.

# Usage: ./SimResultsGroup-Runner.zsh

cd Data

../SimResultsGroup.rb Results-8R.csv  1 2958 >| Results-8R-Mean.txt
../SimResultsGroup.rb Results-12R.csv 1 2958 >| Results-12R-Mean.txt
../SimResultsGroup.rb Results-12R.csv 1 24   >| Results-12R-Mean-Alone.txt

../SimResultsGroup.rb Results-8R.csv  2 5694 >| Results-8R-Longest.txt
../SimResultsGroup.rb Results-12R.csv 2 5694 >| Results-12R-Longest.txt
../SimResultsGroup.rb Results-12R.csv 2 688  >| Results-12R-Longest-Alone.txt

../SimResultsGroup.rb Results-8R.csv  3 1440 >| Results-8R-Above.txt
../SimResultsGroup.rb Results-12R.csv 3 1440 >| Results-12R-Above.txt
