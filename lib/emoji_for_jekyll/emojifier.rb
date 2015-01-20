require 'json'

module EmojiForJekyll
  class Emojifier
    REGEX = /:[\w\+\-]+:/

    def initialize(document, base_config)
      @document    = document
      @base_config = base_config
    end

    def emojify
      return unless config[:enabled]

      proc = Proc.new do |token|
        stripped_token = token[1..-2]
        if emoji_allowed?(stripped_token) && emoji_exists?(stripped_token)
          image_tag(stripped_token)
        else
          token
        end
      end

      @document.content.gsub!(REGEX, &proc)
      config[:front_matter].each do |key|
        next unless @document.data.has_key?(key)
        @document.data[key].gsub!(REGEX, &proc)
      end
    end

    private
    def config
      return @config if @config

      @config = @base_config.clone
      return @config unless @document.data.has_key?("emoji")

      if @document.data["emoji"].has_key?("enabled")
        @config[:enabled] = !!@document.data["emoji"]["enabled"]
      end

      if @document.data["emoji"]["front_matter"]
        @config[:front_matter] = Array(@document.data["emoji"]["front_matter"])
      end

      if @document.data["emoji"].has_key?("source")
        @config[:source] = @document.data["emoji"]["source"]
      end

      if @document.data["emoji"].has_key?("whitelist") && @document.data["emoji"].has_key?("blacklist")
        @config[:whitelist] = Array(@document.data["emoji"]["whitelist"])
        @config[:blacklist] = Array(@document.data["emoji"]["blacklist"])
      elsif @document.data["emoji"].has_key?("whitelist")
        @config[:whitelist] = Array(@document.data["emoji"]["whitelist"])
        @config[:blacklist] = nil
      elsif @document.data["emoji"].has_key?("blacklist")
        @config[:blacklist] = Array(@document.data["emoji"]["blacklist"])
        @config[:whitelist] = nil
      end

      p config

      @config
    end

    def default_emoji
      @default_emoji ||= Set.new(JSON.parse(IO.readlines(File.expand_path("emoji.json", File.dirname(File.dirname(__FILE__)))).join))
    end

    def custom_emoji
      @custom_emoji ||= {}
      return {} unless config[:source]
      source = File.join(config[:site_source], config[:source])
      return @custom_emoji[source] if @custom_emoji.has_key?(source)

      pairs = Dir.foreach(source).select do |filename|
        %w(svg png jpg jpeg gif).include? File.extname(filename).downcase[1..-1]
      end.map do |filename|
        [File.basename(filename, File.extname(filename)).downcase, File.join("/", config[:source], filename)]
      end

      @custom_emoji[source] = Hash[pairs].freeze
    end

    def emoji_allowed?(emoji)
      if config[:whitelist]
        config[:whitelist].include?(emoji)
      elsif config[:blacklist]
        !config[:blacklist].include?(emoji)
      else
        true
      end
    end

    def emoji_exists?(emoji)
      custom_emoji.include?(emoji) || default_emoji.include?(emoji)
    end

    def image_tag(emoji)
      if custom_emoji.include?(emoji)
        image_source = custom_emoji[emoji]
      else
        image_source = "https://github.global.ssl.fastly.net/images/icons/emoji/#{emoji}.png"
      end

      "<img class='emoji' title='#{emoji}' alt='#{emoji}' src='#{image_source}' height='20' width='20' align='absmiddle'>"
    end
  end
end
