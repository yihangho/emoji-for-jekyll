Gem::Specification.new do |s|
  s.name        = 'emoji_for_jekyll'
  s.version     = '0.2.3'
  s.date        = '2015-12-22'
  s.summary     = 'Seamlessly enable emoji in Jekyll.'
  s.description = 'A plugin for Jekyll that seamlessly enable emoji.'
  s.author      = 'Yihang Ho'
  s.email       = 'me@yihangho.com'
  s.homepage    = 'https://github.com/yihangho/emoji-for-jekyll'
  s.license     = 'MIT'
  s.post_install_message = 'Remember to add `emoji_for_jekyll` to the list of Gems in _config.yml.'
  s.files       = ['lib/emoji_for_jekyll.rb', 'lib/emoji.json']

  s.extra_rdoc_files = ['README.md', 'LICENSE']
end
