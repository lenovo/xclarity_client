module XClarityClient
  class Cabinet

    BASE_URI = '/cabinet'.freeze

    attr_accessor :cabinetName, :chassisList, :complexList, :height, :location, :nodeList,
                  :placeholderList, :room, :storageList, :switchList, :UUID

    def initialize(attributes)
      build_cabinet(attributes)
    end

    def build_cabinet(attributes)
      attributes.each do |key, value|
        begin
          send("#{key}=", value)
        rescue
          $log.warn("UNEXISTING ATTRIBUTES FOR CABINET: #{key}") unless Rails.nil?
        end
      end
    end

  end
end
