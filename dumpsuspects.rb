#!/usr/bin/env ruby

load "./lib/shared.rb"

def isarealname (x)
  if x["member"]["name"] == x["answers"][0]
    then 
      isreal = true
  else if x["answers"][0].empty?
    then
      isreal = true
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
      then puts $memberhash[k]['MeetupName'].to_s + "\t\t\t " + $memberhash[k]['Member_ID'].to_s + "\t " + "Name:___________________________________________".to_s
    end 
  end
}

#File.open(datafile, 'w') do |file|
  #file.write JSON.pretty_generate($memberhash)
#end
