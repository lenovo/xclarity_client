require 'json'
require 'pathname'
require 'pp'

module XClarityClient
  # ManagementServerManagement class
  class ManagementServerManagement < Services::XClarityService
    manages_endpoint ManagementServer

    private

    def start_management_server_updates_import_job(file_type_dict, files, jobid)
      url = "/files#{ManagementServer::BASE_URI}?action=import&jobid=#{jobid}"
      index = 0
      payload = {}
      files.each do |file_name|
        type = file_type_dict[File.extname(file_name)]
        key = 'file_' + (index += 1).to_s
        payload[key.to_sym] = Faraday::UploadIO.new(file_name, type)
      end
      @connection.do_post(url, payload, true)
    end

    def populate_payload_files(files, file_type_dict)
      payload_files = []
      index = 0
      files.each do |file|
        name = File.basename(file)
        payload_file = { :index => index += 1, :name => name.strip,
                         :type => file_type_dict[File.extname(name)].strip,
                         :size => File.size?(file) }
        payload_files.push(payload_file)
      end
      payload_files
    end

    public

    def get_management_server_updates_info(key = nil)
      base_url = ManagementServer::BASE_URI
      url = key.nil? ? base_url : "#{base_url}?key=#{key}"
      msg = "input key=#{key}"
      $lxca_log.info(self.class.to_s + ' ' + __method__.to_s, msg)
      @connection.do_get(url)
    end

    def download_management_server_updates(fixids)
      url = "#{ManagementServer::BASE_URI}?action=acquire"
      opts = { :fixids => fixids }
      request_body = JSON.generate(opts)
      @connection.do_post(url, request_body)
    end

    def import_management_server_updates(files)
      url = "#{ManagementServer::BASE_URI}?action=import"
      file_type_dict = { '.txt' => 'text/plain', '.xml' => 'text/xml',
                         '.chg' => 'application/octet-stream',
                         '.tgz' => 'application/x-compressed' }
      payload_files = populate_payload_files(files, file_type_dict)
      request_body = JSON.generate(:files => payload_files)
      response = @connection.do_post(url, request_body)
      jobid = JSON.parse(response.body)['jobid']
      $lxca_log.info(self.class.to_s + ' ' + __method__.to_s, "jobid: #{jobid}")
      start_management_server_updates_import_job(file_type_dict, files, jobid)
    end

    def apply_management_server_updates(fixids)
      url = "#{ManagementServer::BASE_URI}?action=apply"
      opts = { :fixids => fixids }
      request_body = JSON.generate(opts)
      @connection.do_put(url, request_body)
    end

    def delete_management_server_updates(fixids)
      fixids = fixids.join(',')
      url = "#{ManagementServer::BASE_URI}/#{fixids}"
      @connection.do_delete(url)
    end

    def refresh_management_server_updates_catalog
      url = "#{ManagementServer::BASE_URI}?action=refresh"
      opts = { :mts => ['lxca'] }
      request_body = JSON.generate(opts)
      @connection.do_post(url, request_body)
    end
  end
end
