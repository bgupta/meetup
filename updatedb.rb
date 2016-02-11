#!/usr/bin/env ruby

load "./lib/shared.rb"

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
    # uncomment to print the mismatches
    # puts JSON.pretty_generate(x['member']['member_id'].to_s => { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['answers'][0].to_s })
  end
  return isreal
end
end

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  unless $memberhash.has_key?(k)
    then 
      if isarealname(x)
        then 
          $memberhash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['member']['name'].to_s }
#      $attendeehash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => $memberhash[k]['RealName'].to_s }
          $memberhash[k]['LastName'] = $memberhash[k]['RealName'].split.last.to_str
          $memberhash[k]['FirstName'] = $memberhash[k]['RealName'].gsub($memberhash[k]['LastName'],'').rstrip
        else
          $memberhash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['member']['name'].to_s, 'NameAnswer' => x['answers'][0].to_s }
          $memberhash[k]['LastName'] = $memberhash[k]['RealName'].split.last.to_str
          $memberhash[k]['FirstName'] = $memberhash[k]['RealName'].gsub($memberhash[k]['LastName'],'').rstrip
          ##puts x['member']['member_id'].to_s
        end
  end
}

File.open($datafile, 'w') do |file|
  file.write JSON.pretty_generate($memberhash)
end
#puts JSON.pretty_generate($memberhash)
