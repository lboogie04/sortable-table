# require 'rails/all'
require 'action_controller/railtie'
require 'action_view/railtie'

# config
app = Class.new(Rails::Application)
app.config.secret_token = 'e6c3eab00071ba648d96fc1880264d03546f3e02333b6411ce941fecf9360d0c4449f810e5483562c15a579f4a1cf11d710d33783ec48d07854e42ffc7a59232'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false
# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :items
end

# controllers
class ApplicationController < ActionController::Base; end
class ItemsController < ApplicationController; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
