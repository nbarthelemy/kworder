require 'rubygems'
require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/content_for'

require File.dirname(__FILE__) + '/lib/string.rb'
require File.dirname(__FILE__) + '/lib/helpers.rb'

module Kworder
  class Application < Sinatra::Base

    helpers Kworder::Helpers
    helpers Sinatra::ContentFor

    ########### configuration & settings ###########

    register Sinatra::ConfigFile

    configure do
      config_file "settings.yml"
    end

    set :root, File.dirname(__FILE__)
    set :app_file, __FILE__
    set :port, ENV['PORT']
    #set :views, 'views'
    set :img_dir, File.join(root, 'public','images')
    set :css_dir, File.join(root, 'public','stylesheets')

    ################## filters ####################

    before do
      content_type 'text/html', :charset => 'utf-8'
    end

    ################# variables ###################

    pregex = Regexp.new('\s+(' + %w(aboard about above across after against
      along amid among anti around as at before behind below
      beneath beside besides between beyond but by concerning
      considering despite down during except excepting excluding
      following for from in inside into like minus near of off
      on onto opposite outside over past per plus regarding
      round save since than through to toward towards under
      underneath unlike until up upon versus via with within without).
    join('|') + ')\s+')


    ################### routes ####################

    get '/' do
      erb :index
    end

    post '/' do
      @unique = params[:kwords].
        gsub(/[\+.,\/#!$%\^&\*;:{}=_`~()]+/, ' ').
        gsub(pregex, ' ').
        gsub(/\s+/, ' ').split(' ').uniq.
        join(' ').strip
      erb :index
    end


    run! if app_file == $0

  end
end