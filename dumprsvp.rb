#!/usr/bin/env ruby

load "./lib/jsondb.rb"

$attendeehash = {}

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  if $memberhash.has_key?(k) and $memberhash[k]['Status'] != 'Suspect' and $memberhash[k]['Status'] != 'Bloomberg'
    then
      $attendeehash[k] = $memberhash[k]
  end
}

puts JSON.pretty_generate($attendeehash)

