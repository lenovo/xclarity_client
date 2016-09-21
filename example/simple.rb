require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://127.0.0.1:3000'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)
#
# @includeAttributes = %w(accessState)
# @excludeAttributes = %w(accessState)
# @uuidArray = client.discover_nodes.map { |node| node.uuid  }

# puts client.fetch_nodes(@uuidArray, @includeAttributes, nil)

# puts client.discover_power_supplies
# client.discover_nodes

# puts client.discover_nodes


@includeAttributes = %w(dataHandle)
@excludeAttributes = %w(dataHandle)
@uuidArray = client.discover_power_supplies.map { |node| node.uuid  }
# puts client.fetch_power_supplies([@uuidArray[0]], nil, @excludeAttributes)
# puts @uuidArray[0]

puts client.fetch_power_supplies([@uuidArray[0]], @includeAttributes, nil)
