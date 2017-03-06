module XClarityClient
  class Event
    include XClarityClient::Resource

    BASE_URI = '/events'.freeze
    LIST_NAME = 'eventList'.freeze

    attr_accessor :action, :args, :bayText, :chassisText, :cn, :componentID, :eventClass, :eventDate,
                  :eventSourceText, :eventID, :failFRUs, :failSNs, :flags, :fruSerialNumberText, :localLogID,
                  :localLogSequence, :location, :msg, :msgID, :mtm, :originatorUUID, :parameters,
                  :serialnum, :severity, :severityText, :service, :serviceabilityText, :sourceID,
                  :sourceLogID, :sourceLogSequence, :systemFruNumberText, :systemName,
                  :systemSerialNumberText, :systemText, :systemTypeModelText, :systemTypeText, :timeStamp,
                  :typeText, :userid, :userIDIndex

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
