# coding: utf-8
require 'date'
require 'wareki'
require 'erb'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  @title = "YAML to 履歴書"
  @date = Date.today
  @data_yml = load_as_erb("templates/data.yaml")
  @style_txt = load_as_erb("templates/style.txt")
  erb :index
end

post '/create' do
  @data_yml = params[:data_yml]
  @style_txt = params[:style_txt]
  if !params[:photo].nil?
    @photo = params[:photo][:tempfile]
  end
  p "++AAAAAAAAAAA" 
  p @data_yml
  p @style_txt
  p @photo
  p "--AAAAAAAAAAA"
  'OK'
end

private

  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end
