require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :port     => ENV['LXCA_PORT'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /manageRequest/jobs/<job_id>' do
    it 'should return a non empty array' do
      response = @client.fetch_manage_request('4229')
      expect(response).not_to be_empty
    end
  end

  describe 'POST /manageRequest' do
    context 'Manage discovered devices' do
      it 'Create a manage job to manage the said endpoint' do
        @client.manage_discovered_devices(["10.240.74.210"], "USERID", "Passw0rd", "", "True")
        uri = "#{@host}/manageRequest"
        expect(a_request(:post, uri)).to have_been_made
      end
    end
  end

end
