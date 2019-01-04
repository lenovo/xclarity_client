require 'json'

module XClarityClient
  class RemoteAccessManagement

    def initialize(conf)
      @connection = XClarityClient::Connection.new(conf)
    end

    def remote_control(uuid)
      raise 'UUID must not be blank' if uuid.nil? || uuid.empty?
      con = @connection.do_get(
        "#{RemoteAccess::BASE_URI}/remoteControl", :query => { :uuid => uuid }
      )

      unless con.success?
        $lxca_log.error "XClarityClient::RemoteAccessManagement remote_control", "Request failed"
        raise 'Request failed'
      end

      build_remote_access_object(con)
    end

    private

    SUPPORTED_MIME_TYPES = ['application/*json', 'application/x-java-jnlp-file']

    def build_remote_access_object(connection)
      content_type = connection.headers['Content-Type']
      case content_type
      when /application\/.*json/
        build_json_remote_access_object(connection.body)
      when /application\/x-java-jnlp-file/
        build_jnlp_remote_access_object(connection.body)
      else
        $lxca_log.error(
          "XClarityClient::RemoteAccessManagement build_remote_access_object",
          "Unexpected server response. Expected Content-Type header to be one of these: #{SUPPORTED_MIME_TYPES}."
        )
        raise 'Unexpected Content-Type header'
      end
    end

    def build_json_remote_access_object(resp_body)
      parsed_response = JSON.parse(resp_body)
      RemoteAccess.new({
        :type => :url,
        :resource => parsed_response['url']
      })
    end

    def build_jnlp_remote_access_object(resp_body)
      RemoteAccess.new({
        :type => :java_jnlp_file,
        :resource => resp_body
      })
    end
  end
end
