#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

class SlackUp
  def self.render
    print "Ticket: "
    @@ticket = gets.chomp

    print "PR: "
    @@pr = gets.chomp

    print "Deploy: "
    @@deploy = gets.chomp

    print "Concerns seperate by periods: "
    concerns = gets.chomp
    @@concerns = concerns.split('.').map { |con| "\"#{con.strip}\"" }
  end

  def self.format(ticket, pr, deploy, concerns)
"
```
Jonny's Slackup
{
  \"ticket\": #{ticket},
  \"pr\": #{pr},
  \"deploy\": #{deploy},
  \"concerns\": [
      #{concerns.join(",\n      ")}
  ]
}
```
"
  end

  def self.post_to_slack
    print "#{self.format(@@ticket, @@pr, @@deploy, @@concerns)}\n Would you like to post to slack? (y/n)"
    response = gets.chomp

    if response.downcase == "y"
      uri = URI.parse("Your Slack Web Hook")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump({
        "text" => "#{self.format(@@ticket, @@pr, @@deploy, @@concerns)}"
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    elsif response.downcase == "n"
      puts "Aborted"
    else
      puts "Invalid entry aborted."
    end
  end
end

SlackUp.render
SlackUp.post_to_slack
