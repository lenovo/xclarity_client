$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xclarity_client'
require 'apib/mock_server'
require 'webmock/rspec'

base_url = "http://example.com"
blueprint = Pathname(__dir__).join("..", "docs/apib", "aicc.apib").read
app = Apib::MockServer.new(base_url, blueprint)

RSpec.configure do |config|
  config.before do
    stub_request(:any, /#{base_url}/).to_rack(app)
  end
end
