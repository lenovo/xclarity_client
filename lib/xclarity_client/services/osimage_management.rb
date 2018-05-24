require 'json'
require 'pathname'

module XClarityClient
  class OsImageManagement < Services::XClarityService
    manages_endpoint OsImage

    def import_osimage(serverId, path)
        if not Schemas.validate_input_parameter("serverId", serverId, String)
           return
        end

        if not Schemas.validate_input_parameter("path", path, String)
           return
        end
 
        msg="inputs serverId=#{serverId},path=#{path}"
        $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
        opts = { :Action  => "Init" }
        request_body = JSON.generate(opts)
        response = @connection.do_post("#{OsImage::BASE_URI}?imageType=OS", request_body)
        response = JSON.load(response.body).to_hash
        jobId = response["jobId"]
        opts = { :serverId => serverId, :path => path }
        request_body = JSON.generate(opts)
        imageName = path.split(File::SEPARATOR).last
        begin
           response = @connection.do_post("#{OsImage::BASE_URI}?jobId=#{jobId}"\
                              "&imageType=OS&imageName=#{imageName}", request_body)
        rescue Faraday::TimeoutError => e
           result = JSON.generate({ :result => " Job for importing image is in progress with jobId #{jobId}" })
        end
    end
  end
end
