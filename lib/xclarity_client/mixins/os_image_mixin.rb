module XClarityClient
  #
  # Exposes OsImageManagement features
  #
  module Mixins::OsImageMixin
    def import_osimage(server_id = '', path = '')
      OsImageManagement.new(@config).import_osimage(server_id, path)
    end

    def get_osimages
      OsImageManagement.new(@config).fetch_all
    end
  end
end
