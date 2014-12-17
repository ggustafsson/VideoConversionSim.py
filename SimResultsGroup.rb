#!/usr/bin/env ruby

# Written by Göran Gustafsson <gustafsson.g@gmail.com>.

# Note that this is pretty ugly code that is specific for my needs. I use this
# to create data that is later used with SimResultsHistogram.gpi to create the
# specific histograms that i need for my project.

filename = File.basename($0)

unless ARGV.length == 3
  puts "Usage: #{filename} [FILENAME]... [COLUMN]... [MAXVALUE]..."
  exit
end

require "csv"

separator = ";"
file = ARGV[0]
column = Integer(ARGV[1])
maxvalue = Integer(ARGV[2])

range1  = (Float(maxvalue) / 10).ceil # Round upwards so we can divide evenly.
range2  = range1 * 2
range3  = range1 * 3
range4  = range1 * 4
range5  = range1 * 5
range6  = range1 * 6
range7  = range1 * 7
range8  = range1 * 8
range9  = range1 * 9
range10 = range1 * 10

range_values = Array.new(10, 0)

data = CSV.read(file, { :headers => :first_row,
                        :col_sep => separator,
                        :converters => :numeric })

data.each do |row|
  value = row[column - 1]

  case value
  when 0..range1-1 # Zero counts.
    range_values[0] += 1
  when range1..range2-1
    range_values[1] += 1
  when range2..range3-1
    range_values[2] += 1
  when range3..range4-1
    range_values[3] += 1
  when range4..range5-1
    range_values[4] += 1
  when range5..range6-1
    range_values[5] += 1
  when range6..range7-1
    range_values[6] += 1
  when range7..range8-1
    range_values[7] += 1
  when range8..range9-1
    range_values[8] += 1
  when range9..range10 # Go up to 100.
    range_values[9] += 1
  else
    puts "WARNING! Value '#{value}' skipped. Too low MAXVALUE!"
  end
end

if range10 > 100
  puts "0-#{(range1 - 1) / 60} #{range_values[0]}"
  puts "#{range1 / 60}-#{(range2 - 1) / 60} #{range_values[1]}"
  puts "#{range2 / 60}-#{(range3 - 1) / 60} #{range_values[2]}"
  puts "#{range3 / 60}-#{(range4 - 1) / 60} #{range_values[3]}"
  puts "#{range4 / 60}-#{(range5 - 1) / 60} #{range_values[4]}"
  puts "#{range5 / 60}-#{(range6 - 1) / 60} #{range_values[5]}"
  puts "#{range6 / 60}-#{(range7 - 1) / 60} #{range_values[6]}"
  puts "#{range7 / 60}-#{(range8 - 1) / 60} #{range_values[7]}"
  puts "#{range8 / 60}-#{(range9 - 1) / 60} #{range_values[8]}"
  puts "#{range9 / 60}-#{range10 / 60} #{range_values[9]}"
else
  puts "0-#{range1 - 1} #{range_values[0]}"
  puts "#{range1}-#{range2 - 1} #{range_values[1]}"
  puts "#{range2}-#{range3 - 1} #{range_values[2]}"
  puts "#{range3}-#{range4 - 1} #{range_values[3]}"
  puts "#{range4}-#{range5 - 1} #{range_values[4]}"
  puts "#{range5}-#{range6 - 1} #{range_values[5]}"
  puts "#{range6}-#{range7 - 1} #{range_values[6]}"
  puts "#{range7}-#{range8 - 1} #{range_values[7]}"
  puts "#{range8}-#{range9 - 1} #{range_values[8]}"
  puts "#{range9}-#{range10} #{range_values[9]}"
end
