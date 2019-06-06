# coding: utf-8
require "optparse"
require "prawn"
require "yaml"
require './lib/cv_maker'
require './lib/txt2yaml'

def parse_option
  args = {}
  OptionParser.new do |op|
    op.on("-i [datafile]", "--input [datafile]") { |v| args[:input] = v }
    op.on("-s [stylefile]", "--style [stylefile]") { |v| args[:style] = v }
    op.on("-o [output]", "--output [output]") { |v| args[:output] = v }
    op.parse!(ARGV)
  end
  args
end

def check_fonts
  $font_faces.each do |k, v|
    if !File.exists?(v)
      puts <<-EOS
Font files are not found.
Please download IPAex fonts via

https://ipafont.ipa.go.jp/node26

and place them as 

├── fonts
│   ├── ipaexg.ttf
│   └── ipaexm.ttf
└── make_cv.rb
EOS

      exit
    end
  end
end

def cerate_pdf(input_file, style_file, output_file)
  @data = YAML.load_file(input_file)
  if style_file =~ /\.txt$/
    @style = TXT2YAMLConverter.new.load(style_file)
  else
    @style = YAML.load_file(style_file)
  end

  puts "input  file: #{input_file}"
  puts "style  file: #{style_file}"
  puts "output file: #{output_file}"

  @doc = CVMaker.new.generate(@data, @style)
  @doc.render_file output_file
  puts "Done."
end

check_fonts

args = parse_option
input_file = args.fetch(:input, "data.yaml")
style_file = args.fetch(:style, "style.txt")
output_file = args.fetch(:output, "output.pdf")

cerate_pdf(input_file, style_file, output_file)
