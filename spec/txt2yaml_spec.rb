require './lib/txt2yaml.rb'

describe "TXT2YAMLConverter" do
  before do
    @converter = TXT2YAMLConverter.new
  end

  it "should convert style.txt to style array" do
    style = @converter.load('style.txt')
    expect(style.size).to be > 0
  end

  it "should convert academic.txt to style array" do
    style = @converter.load('academic.txt')
    expect(style.size).to be > 0
  end
end
