# require File.expand_path '../spec_helper.rb', __FILE__
require './app.rb'

describe "Sinatra Application" do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
  end
end
