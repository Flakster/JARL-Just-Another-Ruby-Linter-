#!/usr/bin/env ruby
require_relative '../lib/rules'


def create_rules
  arr = []
  arr[0] = FileSize.new('Max. Number of lines per file')
  arr
end

input_array = ARGV
files = []
if input_array.length.zero?
  files = Dir.glob("**/**.ruby")
  if files.count.zero?
    puts 'No file was found'
    exit (false)
  end
else
  file_name = input_array[0]
  unless File.exists?(file_name)
    puts "ERROR: File #{input_array[0]} doesn't exist"
    exit (false)
  end
  files << file_name
end

rules = create_rules
files.each do |file_name|
  file = File.open(file_name)
  file_data = file.readlines.map(&:chomp)
  rules.each{ |rule| rule.parse(file_data, file_name) }
end
Rule.give_report.each{|l| puts l}