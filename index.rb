require 'sinatra'
require 'httmultiparty'
require 'debugger' if Sinatra::Base.development?
require 'open-uri'
require 'dotenv'
require 'active_record'
require 'sinatra/activerecord'
# require './environments'
require 'bcrypt'
require 'htmlentities'
require "rubypython"

get "/" do
  erb :start
end

post "/coding_challenge" do
  erb :coding_challenge
end

post "/save" do
  redirect to("/")
end
