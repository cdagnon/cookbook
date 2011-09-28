source 'http://rubygems.org'

gem 'rails', '3.0.1'
gem "rake", "0.8.7"
# https://github.com/crowdint/rails3-jquery-autocomplete-app#readme
gem 'rails3-jquery-autocomplete'
gem 'nifty-generators'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development, :test do
#  gem 'cucumber-rails', '0.3.2'		# BDD testing framework based on Features
  gem 'cucumber-rails', '0.4.0'		# Cannot do typical Destroy (generated w cucumber:feature) unless 0.4.0 beta or newer: https://github.com/jnicklas/capybara/issues/235
  gem 'capybara', '0.4.1.1'			# Integrations testing for Rack Applications (Rails)
  gem 'rspec-rails', '2.4.1'		# BDD testing framework
  gem 'webrat', '0.7.3'				# Acceptance testing framework
  gem 'database_cleaner'			# ??? 	http://blog.dharanasoft.com/2011/03/07/getting-started-with-cucumber-and-rails-3/
end

