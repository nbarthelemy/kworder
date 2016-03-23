#!/usr/bin/env ruby

ROOT_PATH = File.expand_path(File.dirname(__FILE__))
ENV['RACK_ENV'] ||= 'development'

require 'rubygems'
require 'bundler'

Bundler.require(:default)

require File.dirname(__FILE__) + '/app.rb'

map '/' do
	run Kworder::Application
end
