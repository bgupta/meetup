#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'uri'
require 'rest_client'
require 'yaml'

config = YAML.load(File.read(ENV['HOME'] + '/.getrsvpmeetup.yml'))

datafile = ENV['HOME'] + '/.getrsvpmeetup.json'

if File.file?(datafile)
  then $memberhash = JSON.load(File.read(datafile))
else $memberhash = {}
end

#cleanednamesfile = ENV['HOME'] + '/Downloads/nylug-out.json'
#orignamesfile = ENV['HOME'] + 'nylug-rsvp-april15-1.json'
orignamesfile = 'nylug-rsvp-april15-1.json'
#newnamesfile = ENV['HOME'] + 'nylug-rsvp-april15-3.json'
newnamesfile = 'nylug-rsvp-april15-3.json'

if File.file?(orignamesfile)
  then $orignameshash = JSON.load(File.read(orignamesfile))
#else $orignameshash = {}
end

if File.file?(newnamesfile)
  then $newnameshash = JSON.load(File.read(newnamesfile))
#else $orignameshash = {}
end

$newnameshash.each { |x|
  k = x[0].to_s
  if $orignameshash.has_key?(k)
    then
      $newnameshash.delete(k)
  end
}

#File.open(datafile, 'w') do |file|
#  file.write JSON.pretty_generate($memberhash)
#end
puts JSON.pretty_generate($newnameshash)

