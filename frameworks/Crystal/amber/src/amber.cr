require "amber"

require "./models/*"
require "./controllers/*"
require "./pipes/*"
require "../config/*"

Amber::Server.start
