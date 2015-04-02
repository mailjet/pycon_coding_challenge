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

set :port, 4567
Dotenv.load

class PyconCodingChallenge < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end

class Coder < ActiveRecord::Base
  serialize :array
  validates_presence_of :name
  validates_presence_of :email
end

get "/" do
  erb :start
end

post "/coding_challenge" do
  array = determine_coding_challenge_variant
  Coder.create!(name: params[:name], email: params[:email], company: params[:company], position: params[:position], array: array)
  erb :coding_challenge
end

post "/save/:id" do
  @coder = Coder.find(params[:id])
  @coder.update_attributes(answer: params[:answer], correct: params[:correct], time: params[:time])
  redirect to("/")
end

def determine_coding_challenge_variant
  array = 100.times.map{Random.rand(100)}
  return coding_challenge_variant
end
