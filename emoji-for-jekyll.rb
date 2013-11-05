module Emoji
	class EmojiGenerator < Jekyll::Generator
		def generate(site)
			site.pages.each { |p| substitute p }

			site.posts.each { |p| substitute p }
		end

		private
		def substitute(obj)
			puts obj.data
			if obj.data.has_key?("emoji") and !obj.data["emoji"]
				puts "skip"
				return
			end
			puts "continue"

			obj.content.gsub!(/:(\w+):/) do |s|
				img_tag $1
			end
		end

		def img_tag(name)
			"<img class=\"emoji\" title=\"#{name}\" alt=\"#{name}\" src=\"https://github.global.ssl.fastly.net/images/icons/emoji/#{name}.png\" height=\"20\" width=\"20\" align=\"absmiddle\">"
		end
	end
end
