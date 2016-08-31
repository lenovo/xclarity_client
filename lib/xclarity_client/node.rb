require 'json'

module XClarityClient
  class Node < XClarityBase

    BASE_URI = '/nodes'.freeze

    # accessState
    # activationKeys
    # addinCardSlots
    # addinCards
    # arch
    # backedBy
    # bladeState
    # bootMode
    # bootOrder
    # cmmDisplayName
    # cmmHealthState
    # complexID
    # contact
    # dataHandle
    # description
    # dnsHostnames
    # domainName
    # driveBays
    # drives
    # embeddedHypervisorPresence
    # encapsulation
    # errorFields
    # excludedHealthState
    # expansionCardSlots
    # expansionCards
    # expansionProductType
    # expansionProducts
    # firmware
    # flashStorage
    # FRU
    # fruSerialNumber
    # hasOS
    # height
    # hostMacAddresses
    # hostname
    # ipInterfaces
    # ipv4Addresses
    # ipv6Addresses
    # isConnectionTrusted
    # isITME
    # isRemotePresenceEnabled
    # isScalable
    # lanOverUsb
    # leds
    # location
    # macAddress
    # machineType
    # manufacturer
    # manufacturerId
    # memoryModules
    # memorySlots
    # mgmtProcIPaddress
    # model
    # name
    # nist
    # onboardPciDevices
    # overallHealthState
    # partNumber
    # partitionID
    # pciCapabilities
    # pciDevices
    # ports
    # posID
    # powerAllocation
    # powerCappingPolicy
    # powerStatus
    # powerSupplies
    # processorSlots
    # processors
    # productId
    # productName
    # raidSettings
    # secureBootMode
    # serialNumber
    # slots
    # status
    # subSlots
    # subType
    # tlsVersion
    # type
    # uri
    # userDescription
    # uuid
    # vnicMode
    # vpdID

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def populate
      response = connection(BASE_URI)
      response.body
    end

  end
end
