require 'spec_helper'
require 'json'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :port     => ENV['LXCA_PORT'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL'],
    :user_agent_label => ENV['LXCA_USER_AGENT_LABEL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
    @user_agent = ENV['LXCA_USER_AGENT_LABEL']

  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /updateRepositories/firmware' do

    context 'without any options' do
      it 'should throw an error' do
        expect {@client.discover_update_repo}.to raise_error(RuntimeError, 'Option key must be provided for update_repo resource')
      end
    end

    context 'with option key and an invalid value' do
      it 'should throw an error' do
        expect {@client.discover_update_repo({"key":"Stopped"}).class}.to raise_error(RuntimeError, 'The value for option key should be one of these : supportedMts, lastRefreshed, size, importDir, publicKeys, updates, updatesByMt, updatesByMtByComp')
      end
    end

    context 'with option key and value set to supportedMts' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"supportedMts"})).not_to be_empty
      end
    end

    context 'with option key and value set to lastRefreshed' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"lastRefreshed"})).not_to be_empty
      end
    end

    context 'with option key and value set to size' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"size"})).not_to be_empty
      end
    end

    context 'with option key and value set to importDir' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"importDir"})).not_to be_empty
      end
    end

    context 'with option key and value set to publicKeys' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"publicKeys"})).not_to be_empty
      end
    end

    context 'with option key and value set to updates' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updates"})).not_to be_empty
      end
    end

    context 'with option key and value set to updatesByMt' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updatesByMt"})).not_to be_empty
      end
    end

    context 'with option key and value set to updatesByMtByComp' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updatesByMtByComp"})).not_to be_empty
      end
    end

  end

  describe 'PUT /updateRepositories/firmware?action=read' do
    context 'read update repo' do
      it 'Reloads the repository files' do
        @client.read_update_repo
        uri = "#{@host}/updateRepositories/firmware?action=read"
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made         
      end
    end
  end

  describe 'PUT /updateRepositories/firmware?action=refresh' do
    context 'validate argument combination' do
      it 'validates the combination of arguments action and scope' do
        expect {@client.refresh_update_repo("dummy",["1234"],"")}.to raise_error(RuntimeError, "Invalid argument combination of action and scope. Action refresh can have scope as either all or latest")
      end
    end

    context 'refresh update repo' do
      it 'Retrieves information about the latest available firmware updates from the Lenovo Support website, and stores the information to the firmware-updates repository.' do
        @client.refresh_update_repo("all",["1234"],"")
        uri = "#{@host}/updateRepositories/firmware?action=refresh&with=all"

        refresh_json = JSON.generate(mt: ["1234"], os: "", type: "catalog")
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => refresh_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

  describe 'PUT /updateRepositories/firmware?action=acquire' do
    context 'validate argument combination' do
      it 'validates the combination of arguments action and scope' do
        expect {@client.acquire_firmware_updates("dummy",["brcd_fw_bcsw_nos5.0.1_anyos_noarch"],["1234"])}.to raise_error(RuntimeError, "Invalid argument combination of action and scope. Action acquire can have scope as payloads")
      end
    end

    context 'acquire firmware updates' do
      it 'Downloads the specified firmware updates from Lenovo Support website, and stores the updates to the firmware-updates repository.' do
        @client.acquire_firmware_updates("payloads",["brcd_fw_bcsw_nos5.0.1_anyos_noarch"],["1234"])
        uri = "#{@host}/updateRepositories/firmware?action=acquire&with=payloads"

        acquire_json = JSON.generate(mt: ["1234"], fixids: ["brcd_fw_bcsw_nos5.0.1_anyos_noarch"], type: "latest")
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => acquire_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

  describe 'PUT /updateRepositories/firmware?action=delete' do
    context 'validate argument value' do
      it 'validates the value for argument file_types' do
        expect {@client.delete_firmware_updates("dummy",["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])}.to raise_error(RuntimeError, "Invalid value for argument file_types. Allowed values are - all and payloads")
      end
    end

    context 'delete firmware updates' do
      it 'Deletes the specified firmware updates from the firmware-updates repository.' do
        @client.delete_firmware_updates("payloads",["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])
        uri = "#{@host}/updateRepositories/firmware?action=delete&filetypes=payloads"

        delete_json = JSON.generate(fixids: ["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => delete_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

  describe 'PUT /updateRepositories/firmware?action=export' do
    context 'validate argument value' do
      it 'validates the value for argument file_types' do
        expect {@client.export_firmware_updates("dummy", ["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])}.to raise_error(RuntimeError, "Invalid value for argument file_types. Allowed values are - all and payloads")
      end
    end

    context 'export the firmware updates' do
      it 'Compresses the specified firmware updates from the firmware-updates repository into a ZIP file, and downloads the ZIP file to your local system.' do
        @client.export_firmware_updates("payloads",["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])
        uri = "#{@host}/updateRepositories/firmware?action=export&filetypes=payloads"
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        
        export_json = JSON.generate(fixids: ["brcd_fw_bcsw_nos5.0.1_anyos_noarch"])

        expect(a_request(:put, uri).with(:body => export_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

  
  
end
