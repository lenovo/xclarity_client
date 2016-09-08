require 'xclarity_client'
require 'apib/mock_server'

# base_url = ENV[LOCAL_HOST]
blueprints = ""
# if base_url.eql? ""
  base_url = "http://localhost:9292"
  Dir.glob('docs/apib/*.apib') do |blueprint|
    blueprints << File.open(blueprint).read
  end

  app = Apib::MockServer.new(base_url, blueprints)
  run app
# end
