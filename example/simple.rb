require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://localhost:9292'
)

virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

puts client.discover_nodes

@includeAttributes = %w(accessState)
@excludeAttributes = %w(accessState)
@uuidArray = client.discover_cabinet.map { |cabinet| cabinet.uuid  }

puts client.fetch_cabinet(@uuidArray, @includeAttributes, nil)
