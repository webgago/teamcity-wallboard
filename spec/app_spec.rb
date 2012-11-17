require "spec_helper"

describe 'Wallboard API' do

  let(:app) { Sinatra::Application }

  it "says hello" do
    get '/builds'
    last_response.should be_ok

    expected_array = [
        { "name"        => "rZAGS Client Develop", "status" => "failure",
          "commiters"   => "asozontov",
          "status_text" => 'Tests failed: 44, passed: 867, ignored: 19; process exited with code 1',
          "start_date"  => "2012-11-16T16:15:12+00:00" },

        { "name"        => "rZAGS Retro Develop", "status" => "success",
          "commiters"   => "a.sozontov",
          "status_text" => 'Success',
          "start_date"  => "2012-11-17T16:19:59+00:00" },

        { "name"        => "rZAGS Service Develop", "status" => "failure",
          "commiters"   => "svtyurina",
          "status_text" => 'Tests failed: 1, passed: 0; process exited with code 1',
          "start_date"  => "2012-11-16T16:05:38+00:00" },
    ]

    JSON.parse(last_response.body).should eql expected_array
  end
end
