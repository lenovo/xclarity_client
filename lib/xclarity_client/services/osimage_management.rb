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

    def import_osimage(server_id, path)
      return unless Schemas.validate_input_parameter("serverId", server_id, String) ||
                    Schemas.validate_input_parameter("path", path, String)

      msg="inputs serverId=#{server_id},path=#{path}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      opts = { :Action => "Init" }
      request_body = JSON.generate(opts)
      response = do_post("#{OsImage::BASE_URI}?imageType=OS", request_body)
      response = JSON.load(response.body).to_hash
      job_id = response["jobId"]
      opts = { :serverId => server_id, :path => path }
      request_body = JSON.generate(opts)
      image_name = path.split(File::SEPARATOR).last
      begin
        response = do_post(
          "#{OsImage::BASE_URI}/?jobId=#{job_id}&imageType=OS&imageName=#{image_name}",
          request_body
        )
        JSON.parse(response.body)
      rescue Faraday::TimeoutError => e
        result = JSON.generate(
          :result => " Job for importing image is in progress with jobId #{job_id}"
        )
        JSON.parse(result)
      end
    end
  end
end
