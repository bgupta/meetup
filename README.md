meetup
======

Meetup.com API tools

Note: This code has been tested with Ruby 1.9.3.

+ getrsvpmeetup.rb - Prints an RSVP list for the "next meeting" for a given Meetup group. Reads API key and groupurlname from yml config file. Optional arguments: $1 == groupurlname, which can override config. $2 == meetingid, which overrides default of "next meeting". Will print answer to a single RSVP question if it exists.
+ .getrsvpmeetup.yml.sample - Non working example yml config file (copy to ~/.getrsvpmeetup and customize)

Tools for managing real names via RSVP questions.

+ updatedb.rb - Pulls RSVP information from Meetup API, and updates local JSON datastore. Uses same config file and arguments as getrsvpmeetup.rb. Will create datafile on first use if it doesn't already exist.
+ dumprsvp.rb - Full JSON dump of all attendees. Name information pulled from local datastore if it exists. Uses same config file and arguments as getrsvpmeetup.rb.
+ dumprsvpdirty.rb - JSON lists of RSVPed persons that are flagged suspect or don't have a FirstName field. Uses same config file and arguments as getrsvpmeetup.rb.
+ dumpsuspects.rb - Simple list of RSVPed persons who are flagged suspect in the datastore. Uses same config file and arguments as getrsvpmeetup.rb.
+ msgsuspects.rb - Will open browser tabs on all suspects for a given meeting, to make messaging them easier (to ask for real names)
+ newnames.rb - Compares two JSON RSVP lists, and prints the names in the second file that weren't in the first. JSON output.
+ updatenames.rb - Not ready for use. Generate updated diff name lists from an older RSVP list.

Misc:

+ LICENSE - GPLv2 text
+ README.md - This file

These tools are licensed under GNU General Public License (GPL) version 2 or later.

.getrsvpmeetup.yml - Config file. Should be in $HOME. Contents:

  Groupurlname:  "meetupgroup-name"  
  apikey: ""  
  datafile: "~/.getrsvpmeetup.json"  
  http_proxy: ""  
