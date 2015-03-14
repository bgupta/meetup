#!/usr/bin/env ruby

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

$apikey = config['apikey']
$rpp = 200 # results per page
datafile = ENV['HOME'] + '/.getrsvpmeetup.json'

if File.file?(datafile)
  then $memberhash = JSON.load(File.read(datafile))
else $memberhash = {}
end

RestClient.proxy = config['http_proxy'] if config['http_proxy']
RestClient.proxy = ENV['http_proxy'] if ENV['http_proxy']

response = RestClient.get 'https://api.meetup.com/2/events?key=' +
 $apikey + '&group_urlname=' + $groupurlname + '&page=1&only=id'

if ARGV.size == 2
  then $eventid = ARGV[1]
else $eventid = JSON.parse(response)["results"][0]["id"]
end

def get_page(offset)
  page = RestClient.get "https://api.meetup.com/2/rsvps?key=" +
    $apikey + "&sign=true&event_id=" + $eventid + "&page=" + $rpp.to_s +
    "&offset=" + offset.to_s + "&rsvp=yes&order=name"
  return page
end

def get_attendeecount
  response = get_page(0)
  attendeecount = JSON.parse(response)["meta"]["total_count"]
  return attendeecount
end

pagestoget = get_attendeecount / $rpp + 1

$attendees = []

(0..pagestoget).each do |i|
  response = get_page(i)
  $attendees = $attendees + JSON.parse(response)["results"]
end

def isarealname (x)
  if x["member"]["name"] == x["answers"][0]
    then 
      isreal = true
  else if x["answers"][0].empty?
    then
      isreal = true
  else
    puts JSON.pretty_generate(x['member']['member_id'].to_s => { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['answers'][0].to_s })
  end
  return isreal
end
end

$attendeehash = {}

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  if $memberhash.has_key?(k)
    then
      $attendeehash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => $memberhash[k]['RealName'].to_s }
      $attendeehash[k]['LastName'] = $attendeehash[k]['RealName'].split.last.to_str
      $attendeehash[k]['FirstName'] = $attendeehash[k]['RealName'].gsub($attendeehash[k]['LastName'],'').rstrip
  end
}

puts JSON.pretty_generate($attendeehash)
