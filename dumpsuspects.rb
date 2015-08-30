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
$datafile = File.expand_path(config['datafile'])

if File.file?($datafile)
  then $memberhash = JSON.load(File.read($datafile))
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
#   expr..
#puts x["member"]["member_id"]
#puts JSON.pretty_generate(x.to_json).to_s
#puts JSON.pretty_generate(x["member"])
#puts JSON.pretty_generate(x["answers"])
  if x["member"]["name"] == x["answers"][0]
    then 
      isreal = true
  else if x["answers"][0].empty?
    then
      isreal = true
#      puts "No answer"
#      puts "MeetupName: " + x["member"]["name"].to_s
#      puts "Member_ID: " + x["member"]["member_id"].to_s + " exists"
#      puts "Answer: " + x["answers"][0].to_s 
#puts "They don't match, and they answered the RSVP question"
#puts x["member"]["name"].to_json
  else #puts x["answers"][0].to_json
    puts JSON.pretty_generate(x['member']['member_id'].to_s => { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['answers'][0].to_s })
  end
  return isreal
end
end

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  if $memberhash.has_key?(k)
    then if $memberhash[k]['Status'] == 'Suspect'
      then puts $memberhash[k]['RealName'].to_s + "\t\t\t " + $memberhash[k]['Member_ID'].to_s + "\t " + "Name:___________________________________________".to_s
#      then printf("%-10s %10s",$memberhash[k]['RealName'].to_s,  $memberhash[k]['Member_ID'].to_s,  "Name:_____________________________________________________".to_s)
    end 
#      if isarealname(x)
#        then $memberhash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['member']['name'].to_s }
#      end
#    else puts x['member']['member_id'].to_s
  end
}

#File.open(datafile, 'w') do |file|
  #file.write JSON.pretty_generate($memberhash)
#end
