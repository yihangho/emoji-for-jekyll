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

_or_

1. Copy `emoji_for_jekll.rb` and `emoji.json` into the `_plugins` directory

### GitHub Pages
This plugin (and as a matter of fact, most Jekyll plugins) do not work with GitHub Pages as GitHub
(understandably) do not allow arbitrary code to be executed on their servers. As a result, only
[selected plugins](https://help.github.com/articles/using-jekyll-plugins-with-github-pages/) work
with GitHub pages.

Here are my suggestions if you are using GitHub Pages:

1. Build your site locally and push the content of `_site`.

2. Use [Jemoji](https://help.github.com/articles/emoji-on-github-pages/).

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

### Custom images
By default the images are sourced from GitHub CDN but should you want to use other images you can by choosing a directory with the setting `emoji-images-path` in `_config.yml`. For example: `emoji-images-path: 'img/emoji'`

Images copied into this directory will be added the whitelist. E.g.: `custom.png` would whitelist `:custom:`. Any images with the same name as the emoji list will overwrite the default GitHub emoji image.

## Updating Emoji for Jekyll
Updating Emoji for Jekyll is very easy:

```
gem update emoji_for_jekyll
```
