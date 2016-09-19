require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://127.0.0.1:3000'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

@includeAttributes = %w(partNumber)
@excludeAttributes = %w(partNumber)
@uuidArray = client.discover_fans.map { |node| node.uuid  }

puts client.discover_fans
