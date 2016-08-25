require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://example.com'
)

virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

puts virtual_appliance.configuration_settings
