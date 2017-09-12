module XClarityClient
  class Configtarget
    include XClarityClient::Resource

    BASE_URI = '/config/target'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :access, :children, :description, :firmwareLevel, :id, :ipaddresses, :name, :type, :uuid

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end

