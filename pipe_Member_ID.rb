#!/usr/bin/env ruby
require 'json';
buffer = JSON.parse(STDIN.read)
buffer.each_value { |x|; 
puts x['Member_ID'];
}
