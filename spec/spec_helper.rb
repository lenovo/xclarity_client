$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'xclarity_client'
require 'apib/mock_server'
require 'webmock/rspec'


base_url = "http://example.com"
#This environment variables must to be defined
ENV['LXCA_USERNAME']   ||= ''
ENV['LXCA_PASSWORD']   ||= ''
ENV['LXCA_HOST']       ||= base_url
ENV['LXCA_AUTH_TYPE']  ||= ''
ENV['LXCA_VERIFY_SSL'] ||= 'NONE'

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
