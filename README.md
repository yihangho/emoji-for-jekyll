# Emoji for Jekyll
Seamlessly enable emoji for Jekyll.

## Installation
1. Install the `emoji_for_jekyll` gem:

        gem install emoji_for_jekyll
2. Add `emoji_for_jekyll` to the list of gems in `config.yml`:

  ```yaml
  gems: ["emoji_for_jekyll"]
  ```
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

### Emojify front-matter items
If you need to emojify certain items in your front-matter, like `title` or `caption` that is needed for some templates, you can do so by setting `emoji-additional-keys` in `_config.yml`. This setting is optional and expects an array:

```yaml
emoji-additional-keys: ["title", "caption"]
```

## Custom image path
By default the images are sourced from 'https://github.global.ssl.fastly.net/images/icons/emoji/' but should you want to use other images you can by choosing a directory with the setting `emoji-image-path` in `_config.yml`. For example: `emoji-path: '/img/emoji/'`

## Updating Emoji for Jekyll
Updating Emoji for Jekyll is very easy:

```
gem update emoji_for_jekyll
```
