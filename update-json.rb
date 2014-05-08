#!/usr/bin/env ruby
require 'net/http'
require 'openssl'
require 'json'

uri = URI('https://api.github.com/emojis')

Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Get.new uri
  response = http.request request
  json_obj = JSON.parse response.body
  File.open("lib/emoji.json", "w") do |f|
    f.syswrite json_obj.keys
  end
end
