require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://127.0.0.1:3000'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

@includeAttributes = %w(accessState activationKeys)
@excludeAttributes = %w(accessState activationKeys)
@uuidArray = client.discover_nodes.map { |node| node.uuid  }

puts client.discover_chassis
puts client.fetch_nodes(@uuidArray, nil, @excludeAttributes)
puts client.fetch_chassis(@uuidArray, nil, @excludeAttributes)
# puts client.discover_nodes[0]
