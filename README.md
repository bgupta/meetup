meetup
======

Meetup.com API tools

+ getrsvpmeetup.rb - Prints an RSVP list for the "next meeting" for a given Meetup group. (Reads API key and groupurlname from yml config file. groupurlname can be overridden by an optional argument. Will print answer to a single RSVP question if it exists.
+ .getrsvpmeetup.yml.sample - Non working example yml config file

Tools for managing real names via RSVP questions.

+ updatedb.rb - Pulls RSVP information from Meetup API, and updates local JSON datastore.
+ dumprsvp.rb - Full JSON dump of all attendees. Name information pulled from local datastore if it exists.
+ dumprsvpdirty.rb - JSON lists of RSVPed persons that are flagged suspect or don't have a FirstName field.
+ dumpsuspects.rb - Simple list of RSVPed persons who are flagged suspect in the datastore.
+ newnames.rb - Compares two JSON RSVP lists, and prints the names in the second file that weren't in the first. JSON output.
+ updatenames.rb - Not ready for use.

+ LICENSE - GPLv2 text
+ README.md - This file

These tools are licensed under GNU General Public License (GPL) version 2 or later.

.getrsvpmeetup.yml - Config file. Should be in $HOME
Groupurlname:  "meetupgroup-name"
apikey: "67984326174386286492164832"
http_proxy: ""
datafile: "~/.getrsvpmeetup.json"
