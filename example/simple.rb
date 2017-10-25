require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => '',
  :password => '',
  :host     => '',
  :port => '',
  :auth_type => '',
  :verify_ssl => '',
  :user_agent_label => ''
)

# virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

# puts virtual_appliance.configuration_settings

client = XClarityClient::Client.new(conf)

puts "============= CABINETS ==============="
client.discover_cabinet.map do |cabinet|
  cabinet.instance_variables.each do |att|
    puts "#{att} - #{cabinet.instance_variable_get att}"
  end
end
