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

  describe 'GET /discoverRequest/jobs/job_ID' do
    context 'monitor status of discover request' do
      it 'should return an array' do
        response = @client.monitor_discover_request('215')
        expect(response).not_to be_empty
      end
    end
  end

  describe 'POST /discoverRequest' do
    context 'discover manageable devices' do
      it 'discovers all manageable devices for the given IP address array' do
        @client.discover_manageable_devices(["1.2.3.4"])
        uri = "#{@host}/discoverRequest"
	expect(a_request(:post, uri).with(:body => '[{"ipAddresses":["1.2.3.4"]}]', :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>'Faraday v0.9.2'})).to have_been_made
      end
    end
  end

end
