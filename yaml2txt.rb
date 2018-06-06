require "yaml"

def string(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("value")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def box(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("width")
  a.push h.delete("height")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def photo(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("width")
  a.push h.delete("height")
  puts a.join(",")
end

def line(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("dx")
  a.push h.delete("dy")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def lines(h)
  a = []
  a.push h.delete("type")
  points = h.delete("points")
  a.push points.size
  s = points.shift
  a.push s["x"]
  a.push s["y"]
  points.each do |i|
    a.push i["dx"]
    a.push i["dy"]
  end
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def multi_lines(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("dx")
  a.push h.delete("dy")
  a.push h.delete("num")
  a.push h.delete("sx")
  a.push h.delete("sy")
  puts a.join(",")
end

def education_experience(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("y")
  a.push h.delete("year_x")
  a.push h.delete("month_x")
  a.push h.delete("value_x")
  a.push h.delete("dy")
  a.push h.delete("caption_x")
  a.push h.delete("ijo_x")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def new_page(h)
  puts h.delete("type")
end

def history(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("y")
  a.push h.delete("year_x")
  a.push h.delete("month_x")
  a.push h.delete("value_x")
  a.push h.delete("dy")
  a.push h.delete("value")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

def textbox(h)
  a = []
  a.push h.delete("type")
  a.push h.delete("x")
  a.push h.delete("y")
  a.push h.delete("width")
  a.push h.delete("height")
  a.push h.delete("value")
  a = a + h.collect { |k, v| "#{k}=#{v}" }
  puts a.join(",")
end

if ARGV.size == 0
  puts "usage: input.yaml"
  exit
end

filename = ARGV[0]

y = YAML.load_file(filename)

y.each do |i|
  send(i["type"], i)
end
