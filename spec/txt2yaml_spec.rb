require './lib/txt2yaml.rb'

describe "TXT2YAMLConverter" do
  before do
    @converter = TXT2YAMLConverter.new
    @normal_style = @converter.convert('style.txt')
    @academic_style = @converter.convert('academic.txt')
  end

  it "should convert style.txt to style array" do
    expect(@normal_style.size).to be > 0
  end

  it "should convert academic.txt to style array" do
    expect(@academic_style.size).to be > 0
  end
end
