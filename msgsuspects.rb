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
    puts JSON.pretty_generate(x['member']['member_id'].to_s => { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['answers'][0].to_s })
  end
  return isreal
end
end

$attendees.each { |x|
  k = x['member']['member_id'].to_s
  if $memberhash.has_key?(k)
    then if $memberhash[k]['Status'] == 'Suspect'
      then 
        url = "http://www.meetup.com/members/" + k + "/"
        puts `echo xdg-open #{url}`
#      then puts $memberhash[k]['RealName']
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
