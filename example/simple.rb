require 'xclarity_client'

conf = XClarityClient::Configuration.new(
  :username => 'admin',
  :password => 'pass',
  :host     => 'http://127.0.0.1:3000'
)

client = XClarityClient::Client.new(conf)


# @includeAttributes = %w(accessState activationKeys)
# @excludeAttributes = %w(accessState activationKeys)
#
# puts client.fetch_switches(@uuidArray, nil, @excludeAttributes)
