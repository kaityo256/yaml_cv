# coding: utf-8
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  @title = "YAML to 履歴書"
  erb :index
end
