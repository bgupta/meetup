#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'yaml'

config = YAML.load(File.read(ENV['HOME'] + '/.getrsvpmeetup.yml'))

orignamesfile = ARGV[0]
newnamesfile = ARGV[1]

if File.file?(orignamesfile)
  then $orignameshash = JSON.load(File.read(orignamesfile))
end

if File.file?(newnamesfile)
  then $newnameshash = JSON.load(File.read(newnamesfile))
end

$newnameshash.each { |x|
  k = x[0].to_s
  if $orignameshash.has_key?(k)
    then
      $newnameshash.delete(k)
  end
}

puts JSON.pretty_generate($newnameshash)
