#!/usr/bin/env ruby

def render
  print "Ticket: "
  ticket = gets.chomp

  print "PR: "
  pr = gets.chomp

  print "Deploy: "
  deploy = gets.chomp

  print "Concerns seperate by periods: "
  concerns = gets.chomp

  puts ticket, pr, deploy, concerns
  puts format(ticket, pr, deploy, concerns)
end

def format(ticket, pr, deploy, concerns)
"
{
  \"ticket\": #{ticket},
  \"pr\": #{pr},
  \"deploy\": #{deploy},
  \"concerns\": [
      #{concerns.gsub(".", "\",\n      ")}
  ]
}
"
end

render
