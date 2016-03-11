#!/usr/bin/env ruby

load "./lib/shared.rb"
load "./lib/jsondb.rb"

def isarealname (x)
  if x["member"]["name"] == x["answers"][0]
    then 
      isreal = true
  else if x["answers"][0].empty?
    then
      isreal = true
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
          $memberhash[k]['LastName'] = $memberhash[k]['RealName'].split.last.to_str
          $memberhash[k]['FirstName'] = $memberhash[k]['RealName'].gsub($memberhash[k]['LastName'],'').rstrip
        else
          $memberhash[k] = { 'MeetupName' => x['member']['name'].to_s, 'Member_ID' => x['member']['member_id'].to_s, 'RealName' => x['member']['name'].to_s, 'NameAnswer' => x['answers'][0].to_s }
          $memberhash[k]['LastName'] = $memberhash[k]['RealName'].split.last.to_str
          $memberhash[k]['FirstName'] = $memberhash[k]['RealName'].gsub($memberhash[k]['LastName'],'').rstrip
        end
  end
}

File.open($datafile, 'w') do |file|
  file.write JSON.pretty_generate($memberhash)
end
