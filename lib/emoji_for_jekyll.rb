require 'json'

module EmojiForJekyll
	class EmojiGenerator < Jekyll::Generator
		def generate(site)
			if site.config.has_key?("emoji") and !site.config["emoji"]
				return
			end

			if site.config.has_key?("emoji-additional-keys")
				additional_keys = site.config["emoji-additional-keys"]
			else
				additional_keys = []
			end

			get_master_whitelist

			site.pages.each { |p| substitute(p, additional_keys) }

			site.posts.each { |p| substitute(p, additional_keys) }
		end

		private
		def get_master_whitelist
			# @master_whitelist is an array of all supported emojis
			@master_whitelist = JSON.parse(IO.readlines(File.expand_path("emojis.json", File.dirname(__FILE__))).join)
		end

		def substitute(obj, additional_keys)
			if obj.data.has_key?("emoji") and !obj.data["emoji"]
				return
			end

			whitelist = obj.data.has_key?("emoji-whitelist") ? obj.data["emoji-whitelist"] : false
			blacklist = obj.data.has_key?("emoji-blacklist") ? obj.data["emoji-blacklist"] : false

			# When both the whitelist and blacklist are defined, whitelist will be prioritized
			blacklist = whitelist ? false : blacklist

			obj.content.gsub!(/:([\w\+\-]+):/) do |s|
				if (whitelist and whitelist.include?($1)) or (blacklist and !blacklist.include?($1)) or (!whitelist and !blacklist) and @master_whitelist.bsearch { |i| i >= $1 } == $1
					img_tag $1
				else
					s
				end
			end

			additional_keys.each do |key|
				if obj.data.has_key?(key)
					obj.data[key].gsub!(/:([\w\+\-]+):/) do |s|
						if (whitelist and whitelist.include?($1)) or (blacklist and !blacklist.include?($1)) or (!whitelist and !blacklist) and @master_whitelist.bsearch { |i| i >= $1 } == $1
							img_tag $1
						else
							s
						end
					end
				end
			end
		end

		def img_tag(name)
			"<img class=\"emoji\" title=\"#{name}\" alt=\"#{name}\" src=\"https://github.global.ssl.fastly.net/images/icons/emoji/#{name}.png\" height=\"20\" width=\"20\" align=\"absmiddle\">"
		end
	end
end
