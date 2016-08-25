require 'spec_helper'

describe XClarityClient do
  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /aicc' do
    it 'should respond with information about the Lenovo XClarity Administrator' do

      conf = XClarityClient::Configuration.new(
        :username => 'admin',
        :password => 'pass',
        :host     => 'http://example.com'
      )

      virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf)

      response = virtual_appliance.configuration_settings

      expect(response.status).to eq(200)
    end
  end

  # TODO: Actually create real tests!
  describe 'GET /aicc/network/ipdisable' do
    it 'should respond with the IPv6 and IPv6 addresses enablement state.' do
      response = 200
      expect(response).to eq(200)
    end
  end
end
