#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: bangalter.rb [options]'

  opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
    options[:verbose] = v
  end

  opts.on('-i', '--input SOURCE', 'Source folder to read music from (~/Music/local)') do |i|
    options[:source_folder] = i
  end

  opts.on('-o', '--output TARGET', 'Target folder on Android device (ex: /sdcard/Music)') do |o|
    options[:target_folder] = o
  end

  opts.on('-c', '--compress 320', 'If specified, bitrate to compress to (ex: 320)') do |c|
    options[:compression] = c
  end

  opts.on('-y', 'Accept incoming prompts') do |y|
    options[:yes] = y
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

puts options
puts ARGV
