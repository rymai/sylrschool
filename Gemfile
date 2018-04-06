source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#------------------------
# syl added begin
#------------------------
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'execjs'
#syl windows gem 'therubyracer'
#syl linux gem 'pg', '0.19.0'
gem 'pg', '~> 0.21.0'
# pour rails4 et les attr_accessible
gem 'protected_attributes'

#you may encounter a TZInfo::DataSourceNotFound exception with the message 
#No source of timezone data could be found . 
#The error indicates that TZInfo was unable to find a source of time zone data on your system. 
#This will typically occur if you are using Windows.
#The simplest way to resolve this error is to install the tzinfo-data gem
gem "tzinfo-data"

#user and connections management
gem 'devise'

# oblige sur windows
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt' 

gem 'simple_calendar'

# for export the batabase
# rake db:data:dump
# import
# rake db:data:load
#
gem 'yaml_db'

# for select_in_out in views
#gem 'sylrplm_ext', :git => "https://github.com/sylvani/sylrplm_ext.git"
gem 'sylrplm_ext', :path => "C:/trav/ror/sylrplm_ext"
# for list of objects
gem 'datagrid' 

# pour eviter l'erreur Cet objet ne gère pas cette propriété ou cette méthode sur l'appel a javascript_tag !!!
gem 'coffee-script-source', '1.8.0'

# gestion de la pagination
gem 'will_paginate'

# traitement de texte dans textarea
gem 'ckeditor'
#------------------------
# syl added end
#------------------------

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

