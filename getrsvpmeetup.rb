#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'uri'
require 'rest_client'
require 'yaml'

config = YAML.load(File.read(ENV['HOME']+"/.getrsvpmeetup.yml"))

$groupurlname = config["groupurlname"]
$apikey = config["apikey"]
$rpp = 200 # results per page

RestClient.proxy = config["http_proxy"] if config["http_proxy"]
RestClient.proxy = ENV["http_proxy"] if ENV["http_proxy"]

response = RestClient.get "https://api.meetup.com/2/events?key=" +
 $apikey + "&group_urlname=" + $groupurlname + "&page=1&only=id"

$eventid = JSON.parse(response)["results"][0]["id"]

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

$attendees = Array.new

(0..pagestoget).each do |i|
  response = get_page(i)
  $attendees = $attendees + JSON.parse(response)["results"]
end

$attendees.each { |x|
  puts x["member"]["name"].to_s
#  puts "MeetupName: " + x["member"]["name"].to_s
#  puts "Member_ID: " + x["member"]["member_id"].to_s
#  puts "Answer: " + x["answers"][0].to_s
#  puts
}
