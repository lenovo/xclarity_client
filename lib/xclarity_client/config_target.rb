module XClarityClient
  class ConfigTarget
    include XClarityClient::Resource

    BASE_URI = '/config/target'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :access, :children, :description, :firmwareLevel, :id, :ipaddresses, :name, :type, :uuid, :identifier, :label, :items

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end

