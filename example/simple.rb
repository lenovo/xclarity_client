require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'USER-HERE',
  :password => 'PASSWORD-HERE',
  :host     => 'HOST_DOMAIN_HERE',
  :auth_type => 'TYPE_OF_AUTHENTICATION'
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

puts client.discover_chassis
