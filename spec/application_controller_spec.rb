require_relative "spec_helper"
require_relative "/"

describe ApplicationController do
  it "Responds with welcome message" do
    get '/'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Welcome!")
  end
end
