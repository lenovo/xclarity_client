module XClarityClient
  class Discover

    RESOURCE = ''.freeze #TODO: Define correct resource to get LXCA servers

    def self.responds?(ipAddress, port)
      conf = Faraday.new(url: build_uri(ipAddress, port).to_s) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT -- This line, should be uncommented if you wanna inspect the URL Request
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.ssl[:verify] = false
      end

      response = conf.get RESOURCE

      return false if response.status != 200
      false
    end

    private

    def self.build_uri(ipAddress, port)
      URI("https://" + ipAddress+ ":" + port)
    end
  end
end