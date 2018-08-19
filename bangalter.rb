#!/usr/bin/env ruby

require "optparse"
require "find"
require "artii"
require "colorize"

require_relative "lib/audio"

LOGO_FONT = Artii::Base.new :font => "doom"
LOGO = LOGO_FONT.asciify("bangalter").colorize(:red)

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: bangalter.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-i", "--input SOURCE", "Source folder to read music from (~/Music/local)") do |i|
    options[:source_folder] = i
  end

  opts.on("-o", "--output TARGET", "Target folder on Android device (ex: /sdcard/Music)") do |o|
    options[:target_folder] = o
  end

  opts.on("-c", "--compress 320", "If specified, bitrate to compress to (ex: 320)") do |c|
    options[:compression] = c
  end

  opts.on("-y", "Accept incoming prompts") do |y|
    options[:yes] = y
  end

  opts.on("-L", "Test transcode results by treating target folder as a local folder") do |l|
    options[:local] = l
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!

# test for sufficient options
is_good = true
if options[:source_folder] == nil or File.directory?(options[:source_folder]) == false
  puts "#{options[:source_folder]} source folder is not a directory"
  is_good = false
end
if options[:compression] == nil
  puts "Compression disabled"
else
  puts "Compression enabled (#{options[:compression]}kb/s)"
end
if !is_good
  puts options
  exit(1)
end



# test passed
puts LOGO
puts "options: #{options}"
puts "ARGV: #{ARGV}"

# TODO: check sizes against capacity


# Transcode and copy according to settings

total_size = 0
Find.find(options[:source_folder]) do |path|
  if FileTest.directory?(path)
    if File.basename(path)[0] == ?.
      #Find.prune # Don't look any further into this directory.
    else
      next
    end
  else
    total_size += FileTest.size(path)

    Audio.process_file(path: path, parsed_options: options)
  end
end

puts "#{total_size} bytes"

# From: https://unix.stackexchange.com/questions/227653/how-do-i-get-available-space-with-df-and-output-it-to-a-log-file
# Getting device storage capacity via ADB:
# $ adb shell 'df /storage/emulated'
#
# Filesystem     1K-blocks     Used Available Use% Mounted on
# /data/media     54595836 34597112  19851268  64% /storage/emulated
#
# Getting only Available: 
# $ adb shell 'df /storage/emulated/' | awk '$4 ~ /[[:digit:]]+/ { print $4 }' 
#
# Getting only Used:
# $ adb shell 'df /storage/emulated/' | awk '$4 ~ /[[:digit:]]+/ { print $3 }'
#
# These can be added up