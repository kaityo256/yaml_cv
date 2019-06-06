# coding: utf-8
require 'date'
require 'wareki'
require 'erb'
require 'sinatra'
require "sinatra/reloader" if development?

get '/' do
  @title = "YAML to 履歴書"
  @date = Date.today
  @data_yml = load_as_erb("public/data.yaml")
  @style_txt = load_as_erb("public/style.txt")
  erb :index
end

private

  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end
