require 'rubygems'
require 'json'
require 'uri'
require 'rest_client'
require 'yaml'

config = YAML.load(File.read(ENV['HOME'] + '/.getrsvpmeetup.yml'))

if ARGV.empty?
  then $groupurlname = config['groupurlname']
else $groupurlname = ARGV[0]
end

