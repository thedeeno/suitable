# setup bundle
require 'rubygems'
require 'bundler/setup'

require 'redditkit'
require 'twilio-ruby'

require 'dotenv'
Dotenv.load

dest = ENV["TO_PHONE"]

@client =RedditKit::Client.new ENV["REDDIT_KIT_USER"], ENV["REDDIT_KIT_PASS"]
body = @client.links("romance").first.title
body += " "+ @client.links("romance").first.url

@client = Twilio::REST::Client.new ENV["TWILLO_SID"], ENV["TWILLO_TOKEN"]

@client.account.messages.create({
	:from => ENV["FROM_PHONE"], :to => dest,
	:body => body
})

puts "Swooned #{dest}"
