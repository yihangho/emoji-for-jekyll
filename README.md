# Emoji for Jekyll
Seamlessly enable emoji for Jekyll.

## Installation
1. Get a copy of this repository.
2. Copy `emoji-for-jekyll.rb` to `_plugins/` in your Jekyll directory.
3. See beautiful emoji!

## Options
### Whitelist and blacklist
You can also whitelist or blacklist certain emojis. On the posts or pages that you want to whitelist or blacklist certain emojis, add `emoji-whitelist` or `emoji-blacklist` follow by a list of emojis __without__ the colons to the front matter. For example:

```yaml
emoji-whitelist:
  - bowtie
  - blush
 ```

 or

```yaml
emoji-blacklist:
  - smile
```

When both `emoji-whitelist` and `emoji-blacklist` are declared, the effect will be the same as when only the whitelist is declared.

### Disabling
You may choose to disable this plugin for certain posts or pages by adding `emoji: false` to the front matter of these posts and pages.

If, for some reason, you want to disable this plugin for the entire site, you can either remove `emoji-for-jekyll.rb` from `_plugins`, or just add `emoji: false` to `_config.yml`.
