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

#landing page
get "/" do
  debugger
  debugger
  erb :start
end

#create landing page (just backend)
post "/coding_challenge/create" do
  array = determine_coding_challenge_variant
  @coder = Coder.create(name: params[:name], email: params[:email], company: params[:company], position: params[:position], array: array)
  redirect to("/coding_challenge/#{@coder.id}")
end

#actual coding session
get "/coding_challenge/:id" do
  @coder = Coder.find(params[:id])
  erb :coding_challenge
end

#save the results
post "/save/:id" do
  # debugger
  # debugger
  @coder = Coder.find(params[:id])
  @coder.update_attributes(answer: params[:answer], is_correct: is_correct(@coder.array), time: params[:time])
  redirect to("/")
end

def determine_coding_challenge_variant
  array = 100.times.map{Random.rand(100)}
  return array
end

#method will change depending on challenge
def is_correct(array)

end
