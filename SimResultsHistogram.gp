#!/usr/bin/env gnuplot

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

set style data histogram
set style fill solid border -1
set grid
set yrange [0:1000]
set term svg size 800,500

cd "Output"

set xtic rotate by -45

set output 'Output-Mean-4R.svg'
plot '../Data/Results-4R-Grouped-Mean.dat' using 2:xtic(1)
set output 'Output-Mean-6R.svg'
plot '../Data/Results-6R-Grouped-Mean.dat' using 2:xtic(1)
set output 'Output-Mean-8R.svg'
plot '../Data/Results-8R-Grouped-Mean.dat' using 2:xtic(1)
set output 'Output-Mean-10R.svg'
plot '../Data/Results-10R-Grouped-Mean.dat' using 2:xtic(1)

set output 'Output-Longest-4R.svg'
plot '../Data/Results-4R-Grouped-Longest.dat' using 2:xtic(1)
set output 'Output-Longest-6R.svg'
plot '../Data/Results-6R-Grouped-Longest.dat' using 2:xtic(1)
set output 'Output-Longest-8R.svg'
plot '../Data/Results-8R-Grouped-Longest.dat' using 2:xtic(1)
set output 'Output-Longest-10R.svg'
plot '../Data/Results-10R-Grouped-Longest.dat' using 2:xtic(1)

set xtic rotate by 0

set output 'Output-Above-4R.svg'
plot '../Data/Results-4R-Grouped-Above.dat' using 2:xtic(1)
set output 'Output-Above-6R.svg'
plot '../Data/Results-6R-Grouped-Above.dat' using 2:xtic(1)
set output 'Output-Above-8R.svg'
plot '../Data/Results-8R-Grouped-Above.dat' using 2:xtic(1)
set output 'Output-Above-10R.svg'
plot '../Data/Results-10R-Grouped-Above.dat' using 2:xtic(1)
