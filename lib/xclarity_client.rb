require 'xclarity_client/version'
require 'utils/logger'

module XClarityClient
  $lxca_log = XClarityClient::XClarityLogger.new
end

require 'xclarity_client/errors/errors'

require 'xclarity_client/configuration'
require 'xclarity_client/xclarity_base'
require 'xclarity_client/xclarity_resource'
require 'xclarity_client/xclarity_power_management_mixin'
require 'xclarity_client/xclarity_credentials_validator'
require 'xclarity_client/discover'
require 'xclarity_client/client'

require 'xclarity_client/services/services'
require 'xclarity_client/endpoints/endpoints'
