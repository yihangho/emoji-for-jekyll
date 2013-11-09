require 'net/http'
require 'openssl'
require 'json'

if ARGV.length and ARGV[0] == "-w"
	uri = URI('https://api.github.com/emojis')

	Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
		request = Net::HTTP::Get.new uri
		response = http.request request
		json_obj = JSON.parse response.body
		File.open("emojis.json", "w") do |f|
			f.syswrite json_obj.keys
		end
	end
end
