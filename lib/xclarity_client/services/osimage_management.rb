require 'json'
require 'pathname'

module XClarityClient
  class OsImageManagement < Services::XClarityService
    manages_endpoint OsImage

    def import_osimage(server_id, path)
      msg="inputs serverId=#{server_id},path=#{path}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      opts = { :Action => "Init" }
      request_body = JSON.generate(opts)
      response = @connection.do_post("#{OsImage::BASE_URI}?imageType=OS",
                                     request_body)
      response = JSON.load(response.body).to_hash
      job_id = response["jobId"]
      opts = { :serverId => server_id, :path => path }
      request_body = JSON.generate(opts)
      image_name = path.split(File::SEPARATOR).last
      begin
        response = @connection.do_post('/files'\
                                       + '#{OsImage::BASE_URI}?jobId=#{job_id}'\
                                       '&imageType=OS&imageName=' + image_name,
                                       request_body)
        response
      rescue Faraday::TimeoutError => e
        result = {
          :result => "importing image is in progress with jobId #{job_id}"
        }
        result
      end
    end
  end
end
