module XClarityClient
  class ConfigProfile < Endpoints::XclarityEndpoint
    BASE_URI = '/profiles'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :identifier, :items, :label, :profileName, :serverName, :uuid, :chassisName, :bayId,
    :subBayId, :profileStatus, :templateName, :templateId, :type, :id, :externalId, :managementPatternPresent,
    :addressPresent, :rackId, :unit, :ID, :name, :displayName, :displayId, :endPointType, :endPointId,
    :profilePath, :forScalableSecondaryNode, :secondaryProfileIDs, :serverTemplateId, :commands, :dynamicProperties,
    :primaryProfileID, :forScalableNode, :forScalablePrimaryNode, :deviceId, :deviceType, :managementPatternPresent,
    :rackID, :templateID, :complianceStatus
  end
end

