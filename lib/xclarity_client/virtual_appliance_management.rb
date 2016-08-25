module XClarityClient
  class VirtualApplianceManagement < XClarityBase

    BASE_URI          = '/aicc'.freeze
    NETWORK_URI       = '/network'.freeze
    IPDISABLE_URI     = '/ipdisable'.freeze
    HOST_URI          = '/host'.freeze
    INTERFACES_URI    = '/interfaces'.freeze
    ROUTES_URI        = '/routes'.freeze
    SUBSCRIPTIONS_URI = '/subscriptions'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def configuration_settings
      response = connection
      response
    end

    def configuration_settings=()
    end

    def ip_enablement_state
      uri = BASE_URI+NETWORK_URI+IPDISABLE_URI
      response = connection(uri)
      response
    end

    def ip_enablement_state=()

    end

    def host_settings
      uri = BASE_URI+NETWORK_URI+IPDISABLE_URI
      response = connection(uri)
      response
    end

    def host_settings=()

    end

    def network_interface_settings(interface)
      uri = BASE_URI+NETWORK_URI+INTERFACES_URI+"/#{interface}"
      response = connection(uri)
      response
    end

    def host_settings=()

    end

    def route_settings
      uri = BASE_URI+NETWORK_URI+ROUTES_URI
      response = connection(uri)
      response
    end

    def route_settings=()

    end

    def subscriptions
      uri = BASE_URI+SUBSCRIPTIONS_URI
      response = connection(uri)
      response
    end

    def subscriptions=()

    end


  end
end
