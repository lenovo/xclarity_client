module XClarityClient
  class ConfigTarget < Endpoints::XclarityEndpoint
    BASE_URI = '/config/target'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :access, :children, :description, :firmwareLevel, :id, :ipaddresses, :name, :type, :uuid, :identifier, :label, :items
  end
end

