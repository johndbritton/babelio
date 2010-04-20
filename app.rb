require 'rubygems'
require 'sinatra'
require 'builder'
require 'rest_client'
require 'json'
require 'yaml'

config = YAML::load(File.read('config.yml'))
config.each_pair do |name, value|
  set name.to_sym, value
end

helpers do
  def sms(message)
    RestClient.post 'https://' + settings.username + ':' + settings.password + '@' + settings.twilio_baseurl + '/SMS/Messages', message
  end
  
  def translate(source_text)
    response = RestClient.post settings.translate_baseurl, :v=>settings.translate_version, :q=>source_text, :langpair=>settings.translate_langpair
    translation = JSON.parse(response.body)
    translation['responseData']['translatedText']
  end
end

post '/' do
  builder :welcome
end

post '/record-prompt' do
  builder :record
end

post '/transcription-complete' do
  sms({:From=>params[:Called], :To=>params[:Caller], :Body=>translate(params[:TranscriptionText])})
end

post '/goodbye' do
  builder :goodbye
end