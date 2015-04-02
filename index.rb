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
  erb :start
end

#create landing page (just backend)
post "/coding_challenge/create" do
  coding_challenge_variant = determine_coding_challenge_variant
  @coder = Coder.create(name: params[:name], email: params[:email], company: params[:company], position: params[:position], array: coding_challenge_variant[:array], divisor: coding_challenge_variant[:divisor])
  redirect to("/coding_challenge/#{@coder.id}")
end

#actual coding session
get "/coding_challenge/:id" do
  @coder = Coder.find(params[:id])
  erb :coding_challenge
end

#save the results
post "/save/:id" do
  debugger
  debugger
  @coder = Coder.find(params[:id])
  answer = params[:answer].to_i
  @coder.update_attributes(answer: params[:answer], is_correct: is_correct(@coder.array, @coder.divisor, answer), time: params[:time])
  redirect to("/")
end

#------------------------------------------------------------------------

def determine_coding_challenge_variant
  array = 100.times.map{Random.rand(100)}
  divisor = Random.rand(1...10)
  return {array: array, divisor: divisor}
end

#method will change depending on challenge
def is_correct(array, divisor, answer)
  correct_array = []
  array.each do |elem|
    correct_array << elem if elem % divisor == 1
  end
  if correct_array.length == answer
    return true
  else
    return false
  end
end
