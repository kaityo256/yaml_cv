require "yaml"

module TXT2YAML
  def rest(a, h)
    a.each do |v|
      b = v.split(/=/)
      h[b[0]] = b[1]
    end
  end

  def string(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["value"] = a.shift
    rest(a, h)
    h
  end

  def box(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["width"] = a.shift
    h["height"] = a.shift
    rest(a, h)
    h
  end

  def photo(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["width"] = a.shift
    h["height"] = a.shift
    h
  end

  def line(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["dx"] = a.shift
    h["dy"] = a.shift
    if a.size != 0
      rest(a, h)
    end
    h
  end

  def lines(a)
    h = Hash.new
    h["type"] = a.shift
    n = a.shift.to_i
    points = []
    h["points"] = points
    points << {"x" => a.shift, "y" => a.shift}
    (n - 1).times do
      points << {"dx" => a.shift, "dy" => a.shift}
    end
    rest(a, h)
    h
  end

  def multi_lines(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["dx"] = a.shift
    h["dy"] = a.shift
    h["num"] = a.shift
    h["sx"] = a.shift
    h["sy"] = a.shift
    h
  end

  def education_experience(a)
    h = Hash.new
    h["type"] = a.shift
    h["y"] = a.shift
    h["year_x"] = a.shift
    h["month_x"] = a.shift
    h["value_x"] = a.shift
    h["dy"] = a.shift
    h["caption_x"] = a.shift
    h["ijo_x"] = a.shift
    rest(a, h)
    h
  end

  def new_page(a)
    h = {"type" => "new_page"}
    h
  end

  def history(a)
    h = Hash.new
    h["type"] = a.shift
    h["y"] = a.shift
    h["year_x"] = a.shift
    h["month_x"] = a.shift
    h["value_x"] = a.shift
    h["dy"] = a.shift
    h["value"] = a.shift
    rest(a, h)
    h
  end

  def textbox(a)
    h = Hash.new
    h["type"] = a.shift
    h["x"] = a.shift
    h["y"] = a.shift
    h["width"] = a.shift
    h["height"] = a.shift
    h["value"] = a.shift
    rest(a, h)
    h
  end

  def convert(filename)
    data = []
    open(filename) do |f|
      while line = f.gets
        next if line =~ /^#/
        next if line.chomp == ""
        a = line.chomp.split(/,/)
        d = send(a[0], a)
        data.push d if d != nil
      end
    end
    data
  end
end

class TXT2YAMLConverter
  include TXT2YAML
end

if caller.length == 0
  if ARGV.size == 0
    puts "usage: input.txt"
    exit
  end

  filename = ARGV[0]
  data = TXT2YAMLConverter.new.convert(filename)
  YAML.dump(data, $stdout)
end
