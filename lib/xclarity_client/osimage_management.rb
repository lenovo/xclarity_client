require 'json'
require 'pathname'

module XClarityClient
  class OsImageManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, OsImage::BASE_URI)
    end

    def population
      get_all_resources(OsImage)
    end

    def import_osimage(serverId, path)
        if (not serverId.kind_of?(String)) or (not path.kind_of?(String))
           puts "Invalid input, serverId and path must be of type string"
           return
        end
        msg="inputs serverId=#{serverId},path=#{path}"
        $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
        opts = { "Action": "Init" }
        request_body = JSON.generate(opts)
        response = do_post("#{OsImage::BASE_URI}?imageType=OS", request_body)
        response = JSON.load(response.body).to_hash
        jobId = response["jobId"]
        puts jobId
        opts = { "serverId": serverId, "path": path }
        request_body = JSON.generate(opts)
        imageName = path.split(File::SEPARATOR).last
        begin
           response = do_post("#{OsImage::BASE_URI}/?jobId=#{jobId}"\
                              "&imageType=OS&imageName=#{imageName}", request_body)
           response = JSON.parse(response.body)
        rescue Faraday::TimeoutError => e
           result = JSON.generate({"result": " Job for importing image is in progress with jobId #{jobId}"})
           response = JSON.parse(result) 
        end
    end
  end
end
