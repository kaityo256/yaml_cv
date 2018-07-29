require "yaml"

module TXT2YAML
  DPI = 75

  def size(s)
    if s =~ /\s*(\-?[0-9\.]+)\s*mm/
      $1.to_f / 25.4 * DPI
    elsif s =~ /\s*(-?[0-9\.]+)\s*cm/
      $1.to_f / 25.4 * DPI * 10
    elsif s =~ /\s*(-?[0-9\.]+)\s*px/
      $1.to_f
    else
      s.to_f
    end
  end

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

  def ymbox(a)
    a.shift
    name = a.shift
    y = size(a.shift)
    num = a.shift.to_i
    value = a.shift
    h = Hash[*a.map { |v| v.split(/=/) }.flatten]
    history_fontsize = h.fetch("font_size", 12)
    sy = size("7mm")
    dy = (num + 1) * sy
    namepos = 104 - name.length * 1.7
    r = Array.new
    r.push box("box,0,#{y},177mm,#{dy},line_width=2".split(","))
    r.push line("line,19mm,#{y + dy},0,#{-dy},line_style=dashed".split(","))
    r.push line("line,31mm,#{y + dy},0,#{-dy}".split(","))
    r.push multi_lines("multi_lines,0,#{y + dy - sy},177mm,0,#{num},0,-7mm".split(","))
    r.push history("history,#{y + dy - sy - size("2mm")},3mm,24mm,35mm,-7mm,#{value},font_size=#{history_fontsize}".split(","))
    r.push string("string,8mm,#{y + dy - size("2mm")},年,font_size=9".split(","))
    r.push string("string,24mm,#{y + dy - size("2mm")},月,font_size=9".split(","))
    r.push string("string,#{namepos}mm,#{y + dy - size("2mm")},#{name},font_size=9".split(","))
    return r
  end

  def miscbox(a)
    a.shift
    name = a.shift
    y = size(a.shift)
    height = size(a.shift)
    value = a.shift
    h = Hash[*a.map { |v| v.split(/=/) }.flatten]
    textbox_fontsize = h.fetch("font_size", 12)
    namepos = size((88.5 - name.length * 1.7).to_s + "mm")
    r = Array.new
    r.push string("string,#{namepos},#{y + height - size("2mm")},#{name},font_size=9".split(","))
    r.push line("line,0,#{y + height - size("7mm")},177mm,0".split(","))
    r.push textbox("textbox,2mm,#{y + height - size("9mm")},175mm,#{height - size("9mm")},#{value},font_size=#{textbox_fontsize}".split(","))
    r.push box("box,0,#{y},177mm,#{height},line_width=2".split(","))
    r
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
        next if d == nil
        if d.kind_of?(Array)
          data = data + d
        else
          data.push d
        end
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
