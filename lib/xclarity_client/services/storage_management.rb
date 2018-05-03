module XClarityClient
  #
  # This class provides a set of services related to Storage endpoint
  #
  class StorageManagement < Services::XClarityService
    manages_endpoint Storage
  end
end
