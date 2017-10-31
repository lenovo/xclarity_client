require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- This line should be uncommented if you're using external mock test
  end

  let(:conf) {
    XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      port:       ENV['LXCA_PORT'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )
  }

  let(:client) { XClarityClient::Client.new conf }

  let(:aicc) { client.discover_aicc }

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /aicc' do
    it 'should not be nil' do
      aicc.should_not be_nil
    end

    it 'should has the appliance version' do
      aicc.first.appliance['version'].should_not be_nil
    end
  end

end
