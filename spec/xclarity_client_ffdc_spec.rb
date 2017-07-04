require 'spec_helper'

describe XClarityClient do
  before :all do
    # -- The next line should be uncommented
    # if you're using external mock test
    WebMock.allow_net_connect!

    conf = XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)
  end

  before :each do
    @device_uuidArray = @client.discover_switches.map { |switch| switch.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /ffdc/ID' do
    it 'should respond with a array containing jobURL' do
      response = @client.fetch_ffdc([@device_uuidArray[0]], nil, nil)
      response.map do |ffdc|
        expect(ffdc.send("jobURL")).not_to be_nil
      end
    end
  end

end
