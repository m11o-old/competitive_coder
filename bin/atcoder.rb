require 'optparse'
require 'pathname'
require "open3"

DEFAULT_PATH_NAME = Pathname.new "/Users/ve/competitive_coder/atcoder"

def make_atcoder_dir(convention_name, type)
  type_path = DEFAULT_PATH_NAME.join(convention_name, type)
  Dir.mkdir type_path.to_s
  File.open type_path.join("main.rb").to_s, "w"
end

options = {}
OptionParser.new do |opt|
  opt.on('--ABC num', 'AtCoder Beginner Contest ver. num') {|v| options[:ABC] = v}
  opt.on('--AGC num', 'AtCoder Grand Contest ver. num') {|v| options[:AGC] = v}
  opt.on('--ARC num', 'AtCoder Regular Contest ver. num') {|v| options[:ARC] = v}
  opt.on('-o name', '--other name', 'other contest name') {|v| options[:other] = v}
  opt.on('-f files', '--file files', Array, 'create file count') {|v| options[:file] = v.to_i}

  opt.parse!(ARGV)
end

if options[:ABC]
  Dir.mkdir DEFAULT_PATH_NAME.join("abc_#{options[:ABC]}").to_s
  if options[:file]
    options[:file].each do |file|
      make_atcoder_dir("abc_#{options[:ABC]}", file)
    end
  else
    4.times do |i|
      make_atcoder_dir("abc_#{options[:ABC]}", ("A".."Z").to_a[i])
    end
  end
end

if options[:AGC]
  Dir.mkdir DEFAULT_PATH_NAME.join("agc_#{options[:AGC]}")
  if options[:file]
    options[:file].each do |file|
      make_atcoder_dir("agc_#{options[:AGC]}", file)
    end
  else
    6.times do |i|
      make_atcoder_dir("agc_#{options[:AGC]}", ("A".."Z").to_a[i])
    end
  end
end

if options[:ARC]
  Dir.mkdir DEFAULT_PATH_NAME.join("arc_#{options[:ARC]}")
  if options[:file]
    options[:file].each do |file|
      make_atcoder_dir "arc_#{options[:ARC]}", file
    end
  else
    (2..5).each do |i|
      make_atcoder_dir("arc_#{options[:ARC]}", ("A".."Z").to_a[i])
    end
  end
end

if options[:other]
  Dir.mkdir DEFAULT_PATH_NAME.join(options[:other])
end
