require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://localhost:9292'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)


@includeAttributes = %w(nodeCount)
@excludeAttributes = %w(nodeCount)
# @uuidArray = client.discover_nodes.map { |node| node.uuid  }

# puts client.discover_chassis
# puts client.fetch_switches
# puts client.fetch_nodes(@uuidArray, nil, @excludeAttributes)
# puts client.fetch_chassis(@uuidArray, nil, @excludeAttributes)
puts client.fetch_scalableComplexes(@uuidArray, nil, @excludeAttributes)
