require 'xclarity_client/version'
require 'utils/logger'

module XClarityClient
  $lxca_log = XClarityClient::XClarityLogger.new
end

require 'xclarity_client/errors/errors'

require 'xclarity_client/configuration'
require 'xclarity_client/xclarity_base'
<<<<<<< 30d841cc83ac234d10ff746f6d7a510990c1b7ce
=======
require 'xclarity_client/xclarity_resource'
>>>>>>> Creating abstract service
require 'xclarity_client/xclarity_power_management_mixin'
require 'xclarity_client/xclarity_credentials_validator'
require 'xclarity_client/discover'
require 'xclarity_client/client'
<<<<<<< 30d841cc83ac234d10ff746f6d7a510990c1b7ce
require 'xclarity_client/schemas'
=======
>>>>>>> Creating abstract service

require 'xclarity_client/endpoints/endpoints'
require 'xclarity_client/services/services'
