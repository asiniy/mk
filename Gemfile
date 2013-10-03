source 'https://rubygems.org'

ruby "2.0.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'pg'

# Use Devise for user authentication
gem 'devise', '3.0.2'
gem 'devise-encryptable'
gem 'devise-i18n-views'
gem 'omniauth'
gem 'omniauth-twitter'

gem 'russian'
gem 'activeadmin', github: 'gregbell/active_admin', branch: 'rails4', ref: '6c9e22ab09229b0903942179060c10cf5e3289d8'

# Server part
gem 'heroku'
gem 'figaro'

# Post content
gem 'redactor-rails', '0.3.6'
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'sidekiq'
gem 'sidekiq_mailer', git: 'git://github.com/tubaxenor/sidekiq_mailer.git', ref: 'cc8f6d0cf941d0a43cc694e6d2e20e25081e2d03'
gem 'acts-as-taggable-on'

# Comments
gem 'awesome_nested_set'

gem 'slim-rails'
gem 'will_paginate'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'twitter-bootstrap-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'thin'
  gem 'quiet_assets'

  # Thinking sphinx
  gem 'mysql2', '0.3.13'
  gem 'thinking-sphinx', '~> 3.0.2'
end
