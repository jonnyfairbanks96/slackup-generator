#!/usr/bin/env ruby
# frozen_string_literal: true

require 'uri'
require 'json'
require 'date'

# Script to out put a slackup
class SlackUp
  def self.render
    time = Date.parse(Time.now.to_s)
    path = File.dirname(__FILE__)
    template = File.expand_path("#{path}/slackup_template.txt")
    slack_up = File.expand_path("#{path}/.slackup_#{time}.txt")

    system('cp', template, slack_up) unless File.exist?(slack_up)
    system('nvim', slack_up)
    system('cat', slack_up)
  end
end

SlackUp.render
