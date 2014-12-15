#!/usr/bin/env ruby

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

range1 = (Float(maxvalue) / 10).ceil
range2 = range1 * 2
range3 = range1 * 3
range4 = range1 * 4
range5 = range1 * 5
range6 = range1 * 6
range7 = range1 * 7
range8 = range1 * 8
range9 = range1 * 9
range10 = range1 * 10

range1_value = 0
range2_value = 0
range3_value = 0
range4_value = 0
range5_value = 0
range6_value = 0
range7_value = 0
range8_value = 0
range9_value = 0
range10_value = 0

data = CSV.read(file, { :headers => :first_row,
                        :col_sep => separator,
                        :converters => :numeric })

data.each do |row|
  value = row[column - 1]

  case value
  when 0..range1-1
    range1_value += 1
  when range1..range2-1
    range2_value += 1
  when range2..range3-1
    range3_value += 1
  when range3..range4-1
    range4_value += 1
  when range4..range5-1
    range5_value += 1
  when range5..range6-1
    range6_value += 1
  when range6..range7-1
    range7_value += 1
  when range7..range8-1
    range8_value += 1
  when range8..range9-1
    range9_value += 1
  when range9..range10-1
    range10_value += 1
  else
    puts "WARNING! Value #{value} skipped. Too low MAXVALUE!"
  end
end

puts "R1 #{range1_value}"
puts "R2 #{range2_value}"
puts "R3 #{range3_value}"
puts "R4 #{range4_value}"
puts "R5 #{range5_value}"
puts "R6 #{range6_value}"
puts "R7 #{range7_value}"
puts "R8 #{range8_value}"
puts "R9 #{range9_value}"
puts "R10 #{range10_value}"
