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

## Advanced Options
Emoji for Jekyll works without any extra configuration. However, we do offer customizability for our users. All options mentioned below sit under the `emoji` key in `_config.yml`. In addition to global settings in `_config.yml`, each of these options can also be used in front-matter to overwrite the global settings.

### `enabled`
Set this to `false` to skip disable Emoji for Jekyll for the entire site or a particular post.

### `front_matter`
A list of front-matter keys that should be emojified as well. For example, if we set the following in `_config.yml`:

```yaml
emoji:
  front_matter:
    - title
    - description
    - my_item
```

The values of `title`, `description`, and `my_item` in the front_matter of each post will be emojified.

### `whitelist` and `blacklist`
`whitelist` and `blacklist` can be used to enable or disable only certain emoji. Each of `whitelist` and `blacklist` is an array of emoji token, without the colon. For example:

```yaml
emoji:
  whitelist:
    - smile
    - poop
```

### `source`
By default, the images of emoji used are the same as those used on GitHub. It is, however, possible to use your own images. Set `source` to the directory containing all these images. All images in this directory will become emoji, thereby allowing custom emoji.

```yaml
emoji:
  source: asset/emoji
```

Suppose the `asset/emoji` directory contains the following items:

- smile.jpg
- poop.png
- my_own_emoji_yo.svg

The following will be converted to use these three images:

```
:smile: :poop: :my_own_emoji_yo:
```
