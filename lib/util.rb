require 'erb'
require 'date'
require 'wareki'

module Util
  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end
end
