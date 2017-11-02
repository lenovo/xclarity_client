module XClarityClient
  class Event
    include XClarityClient::Resource

    BASE_URI = '/events'.freeze
    LIST_NAME = 'eventList'.freeze

    attr_accessor :action, :args, :bayText, :chassisText, :cn, :commonEventID, :componentID,
                  :componentIdentifierText, :eventClass, :eventDate, :eventID, :eventSourceText, :failFRUs,
                  :failSNs, :flags, :fruSerialNumberText, :localLogID, :localLogSequence, :location,
                  :msg, :msgID, :mtm, :originatorUUID, :parameters, :senderUUID, :serialnum,
                  :service, :serviceabilityText, :severity, :severityText, :sourceID,
                  :sourceLogID, :sourceLogSequence, :systemFruNumberText, :systemName,
                  :systemSerialNumberText, :systemText, :systemTypeModelText, :systemTypeText,
                  :timeStamp, :typeText, :userid, :userIDIndex

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
