# Emoji for Jekyll
Seamlessly enable emoji for Jekyll.

## Installation
1. Get a copy of this repository.
2. Copy `emoji-for-jekyll.rb` and `emojis.json` to `_plugins/` in your Jekyll directory.
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

### Updating `emojis.json`
`emojis.json` contains the list of supported emojis. Since the images of all emojis are served by GitHub, all the emojis that are not supported by GitHub will not be converted to image tag. However, from time to time, GitHub might support new emojis, and to enable those emojis in this plugin, `emojis.json` should be updated. This can be done by moving `update-json.rb` to the same directory as `emojis.json` and execute `update-json.rb -w`. Please take note of the `-w` flag.

```
$ ls
emojis.json
emoji-for-jekyll.rb
update-json.rb
$ ruby update-json.rb -w
```
