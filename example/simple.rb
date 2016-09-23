require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://127.0.0.1:3000'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

# @includeAttributes = %w(nodeCount)
# @excludeAttributes = %w(nodeCount)
# @uuidArray = client.discover_scalableComplexes.map { |scalableComplex| scalableComplex.uuid  }
#
# puts client.discover_scalableComplexes
#
# puts client.fetch_scalableComplexes(@uuidArray, nil, @excludeAttributes)

# @includeAttributes = %w(accessState activationKeys)
# @excludeAttributes = %w(accessState activationKeys)
#
# puts client.fetch_switches(@uuidArray, nil, @excludeAttributes)


@includeAttributes = %w(accessState)
@excludeAttributes = %w(accessState)
@uuidArray = client.discover_nodes.map { |node| node.uuid  }

puts client.fetch_nodes(@uuidArray, @includeAttributes, nil)
