$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xclarity_client'
require 'apib/mock_server'
require 'webmock/rspec'


#This environment variables must to be defined
ENV['USERNAME_VALUE'] = ''
ENV['PASSWORD_VALUE'] = ''
ENV['HOST_VALUE'] = ''
ENV['AUTH_TYPE_VALUE'] = ''
ENV['SSL_VERIFY'] = ''

base_url = "http://example.com"
blueprints = ""
Dir.glob('docs/apib/*.apib') do |blueprint|
  blueprints << File.open(blueprint).read
end
app = Apib::MockServer.new(base_url, blueprints)

RSpec.configure do |config|
  config.before do
    stub_request(:any, /#{base_url}/).to_rack(app)
  end
end
