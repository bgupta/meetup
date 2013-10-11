#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'uri'
require 'rest_client'
require 'yaml'

config = YAML.load(File.read("getrsvpmeetup.yml"))

groupurlname = config["groupurlname"]
apikey = config["apikey"]

RestClient.proxy = ENV["http_proxy"]
response = RestClient.get "https://api.meetup.com/2/events?key=" +
 apikey + "&group_urlname=" + groupurlname + "&page=1&only=id"
eventid = JSON.parse(response)["results"][0]["id"]

response = RestClient.get "https://api.meetup.com/2/rsvps?key=" +
 apikey + "&sign=true&event_id=" + eventid + "&page=400&rsvp=yes&order=name"

JSON.parse(response)["results"].each { |x| puts x["member"]["name"] }
