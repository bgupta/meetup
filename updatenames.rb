#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'uri'
require 'rest_client'
require 'yaml'

config = YAML.load(File.read(ENV['HOME'] + '/.getrsvpmeetup.yml'))

$datafile = File.expand_path(config['datafile'])

if File.file?($datafile)
  then $memberhash = JSON.load(File.read($datafile))
else $memberhash = {}
end

#cleanednamesfile = ENV['HOME'] + '/Downloads/nylug-out.json'
cleanednamesfile = ENV['HOME'] + '/Downloads/nylug-rsvp-april15-1-clean.json'

if File.file?(cleanednamesfile)
  then $nameshash = JSON.load(File.read(cleanednamesfile))
else $nameshash = {}
end

$nameshash.each { |x|
  k = x[0].to_s
  if $memberhash.has_key?(k)
    then
      $memberhash[k]['RealName'] = x[1]['RealName']
      $memberhash[k]['FirstName'] = x[1]['FirstName']
      $memberhash[k]['LastName'] = x[1]['LastName']
  end
}

File.open($datafile, 'w') do |file|
  file.write JSON.pretty_generate($memberhash)
end
#puts JSON.pretty_generate($memberhash)

