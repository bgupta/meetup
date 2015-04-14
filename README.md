meetup
======

Meetup.com API tools

+ getrsvpmeetup.rb - Prints an RSVP list for the "next meeting" for a given Meetup group. (Reads API key and groupurlname from yml config file. groupurlname can be overridden by an optional argument. Will print answer to a single RSVP question if it exists.
+ .getrsvpmeetup.yml.sample - Non working example yml config file
+ LICENSE - GPLv2 text
+ README.md - This file

These tools are licensed under GNU General Public License (GPL) version 2 or later.

.getrsvpmeetup.yml - Config file. Should be in $HOME
Groupurlname:  "meetupgroup-name"
apikey: "67984326174386286492164832"
http_proxy: ""
datafile: "~/.getrsvpmeetup.json"

dumprsvp.rb  
dumpsuspects.rb 
updatedb.rb
