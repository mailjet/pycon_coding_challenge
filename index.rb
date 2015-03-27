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
  ##determine coding challenge variant (method)
  erb :coding_challenge
end

post "/save" do
  redirect to("/")
end

def determine_coding_challenge_variant
  array = 100.times.map{Random.rand(100)}
  return coding_challenge_variant
end
