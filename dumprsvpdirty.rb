#!/usr/bin/env ruby

load "./lib/jsondb.rb"

$dirtyhash = {}

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  if $memberhash.has_key?(k) and $memberhash[k]['Status'] == 'Suspect'
    then
      $dirtyhash[k] = $memberhash[k]
    elsif  $memberhash.has_key?(k) and !$memberhash[k].has_key?('FirstName')
      then
        $dirtyhash[k] = $memberhash[k]
  end
}

puts JSON.pretty_generate($dirtyhash)
