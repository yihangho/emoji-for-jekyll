module EmojiForJekyll
  class EmojiGenerator < Jekyll::Generator
    def initialize(config)
      warn_deprecated_config(config)

      @site_config = config
    end

    def generate(site)
      # TODO What 'bout collections?
      (site.pages + site.posts).each do |item|
        Emojifier.new(item, config.merge(site_source: site.source)).emojify
      end
    end

    private
    def warn_deprecated_config(config)
      deprecated_keys_used = %w(emoji-whitelist emoji-blacklist emoji-additional-keys emoji-images-path).select do |key|
        config.has_key?(key)
      end

      if deprecated_keys_used.any?
        Jekyll.logger.warn "Deprecation (Emoji for Jekyll):", "Deprecated configuration keys are used. Please refer to the documentation (https://github.com/yihangho/emoji-for-jekyll) for more information."
      end
    end

    def config
      emoji_config = @site_config["emoji"] || {}

      @config ||= {
        enabled:      !emoji_config.has_key?("enabled") || !!emoji_config["enabled"],
        front_matter: Array(emoji_config["front_matter"]),
        whitelist:    emoji_config.has_key?("whitelist") ? Array(emoji_config["whitelist"]) : nil,
        blacklist:    emoji_config.has_key?("blacklist") ? Array(emoji_config["blacklist"]) : nil,
        source:       emoji_config["source"]
      }
    end
  end
end
