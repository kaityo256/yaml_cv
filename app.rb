# coding: utf-8
require 'date'
require 'wareki'
require 'erb'
require 'sinatra'
require 'sinatra/reloader' if development?

require './lib/cv_maker'
require './lib/txt2yaml'

get '/' do
  @title = "YAML to 履歴書"
  @date = Date.today
  @data_yml = load_as_erb("templates/data.yaml")
  @style_txt = load_as_erb("templates/style.txt")
  erb :index
end

post '/create' do
  begin
    @data = YAML.load(params[:data_yml])
    @style = TXT2YAMLConverter.new.convert(params[:style_txt])

    if !params[:photo].nil?
      @photo = params[:photo][:tempfile]
      @data["photo"] = @photo.path
    end

    @doc = CVMaker.new.generate(@data, @style)
    content_type 'application/pdf'
    @doc.render
  rescue => exception
    puts exception
    status 403
    return 'Error'
  end
end

private

  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end
