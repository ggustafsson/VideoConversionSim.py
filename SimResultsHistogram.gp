set style data histogram
set style fill solid border -1
set grid
set yrange [0:1000]
set term png

set output 'Output-Mean-4R.png'
plot 'Results-4R-Grouped-Mean.csv' using 2:xtic(1)

set output 'Output-Mean-6R.png'
plot 'Results-6R-Grouped-Mean.csv' using 2:xtic(1)

set output 'Output-Mean-8R.png'
plot 'Results-8R-Grouped-Mean.csv' using 2:xtic(1)

set output 'Output-Mean-10R.png'
plot 'Results-10R-Grouped-Mean.csv' using 2:xtic(1)


set output 'Output-Longest-4R.png'
plot 'Results-4R-Grouped-Longest.csv' using 2:xtic(1)

set output 'Output-Longest-6R.png'
plot 'Results-6R-Grouped-Longest.csv' using 2:xtic(1)

set output 'Output-Longest-8R.png'
plot 'Results-8R-Grouped-Longest.csv' using 2:xtic(1)

set output 'Output-Longest-10R.png'
plot 'Results-10R-Grouped-Longest.csv' using 2:xtic(1)


set output 'Output-Above-4R.png'
plot 'Results-4R-Grouped-Above.csv' using 2:xtic(1)

set output 'Output-Above-6R.png'
plot 'Results-6R-Grouped-Above.csv' using 2:xtic(1)

set output 'Output-Above-8R.png'
plot 'Results-8R-Grouped-Above.csv' using 2:xtic(1)

set output 'Output-Above-10R.png'
plot 'Results-10R-Grouped-Above.csv' using 2:xtic(1)
