module XClarityClient
  class Discover

    RESOURCE = '/aicc'.freeze

    def self.responds?(ipAddress, port)
      conf = Faraday.new(url: build_uri(ipAddress, port).to_s) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT -- This line, should be uncommented if you wanna inspect the URL Request
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.ssl[:verify] = false
      end

      begin
        response = conf.get do |req|
          req.url RESOURCE
          req.options.timeout = 5           # open/read timeout in seconds
          req.options.open_timeout = 6      # connection open timeout in seconds
        end
      rescue Exception
        return false
      end

      return false if %w(200 302).include? response.status
      true
    end

    private

    def self.build_uri(ipAddress, port)
      URI("https://" + ipAddress+ ":" + port)
    end
  end
end