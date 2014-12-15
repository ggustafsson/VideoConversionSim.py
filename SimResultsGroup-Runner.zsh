#!/usr/bin/env zsh

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

cd Data

../SimResultsGroup.rb Results-4R.csv 1 4313 >| Results-4R-Grouped-Mean.dat
../SimResultsGroup.rb Results-6R.csv 1 4313 >| Results-6R-Grouped-Mean.dat
../SimResultsGroup.rb Results-8R.csv 1 4313 >| Results-8R-Grouped-Mean.dat
../SimResultsGroup.rb Results-10R.csv 1 4313 >| Results-10R-Grouped-Mean.dat

../SimResultsGroup.rb Results-4R.csv 2 8199 >| Results-4R-Grouped-Longest.dat
../SimResultsGroup.rb Results-6R.csv 2 8199 >| Results-6R-Grouped-Longest.dat
../SimResultsGroup.rb Results-8R.csv 2 8199 >| Results-8R-Grouped-Longest.dat
../SimResultsGroup.rb Results-10R.csv 2 8199 >| Results-10R-Grouped-Longest.dat

../SimResultsGroup.rb Results-4R.csv 3 100 >| Results-4R-Grouped-Above.dat
../SimResultsGroup.rb Results-6R.csv 3 100 >| Results-6R-Grouped-Above.dat
../SimResultsGroup.rb Results-8R.csv 3 100 >| Results-8R-Grouped-Above.dat
../SimResultsGroup.rb Results-10R.csv 3 100 >| Results-10R-Grouped-Above.dat
