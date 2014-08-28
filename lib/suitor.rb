# setup bundle
require 'rubygems'
require 'bundler/setup'

# require dependencies
require 'redditkit'
require 'twilio-ruby'

@client =RedditKit::Client.new "ruby_relay_bot", "PahkThaCah"
body = @client.links("romance").first.title
body += " "+ @client.links("romance").first.url

@client = Twilio::REST::Client.new 'ACbb8840b48cc93d4b05e987d82f7a281a', '0f065f163e588424cf645b07e3dbc0cb'

@client.account.messages.create({
	:from => '+18574454093', :to =>'8889157768',
	:body => body
})

puts "Swooned 8889157768"
