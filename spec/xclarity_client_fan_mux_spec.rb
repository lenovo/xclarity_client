
require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect!
    conf = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://127.0.0.1:3000'
    )

    conf_blueprint = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://example.com'
    )

    @virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf_blueprint)
    @client = XClarityClient::Client.new(conf)

    @includeAttributes = %w(productName)
    @excludeAttributes = %w(productName)
    @uuidArray = @client.discover_fan_muxes.map { |fan_mux| fan_mux.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /aicc' do
    it 'should respond with information about the Lenovo XClarity Administrator' do

      response = @virtual_appliance.configuration_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/ipdisable' do
    it 'should respond with the IPv6 and IPv6 addresses enablement state.' do

      response = @virtual_appliance.ip_enablement_state

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/host' do
    it 'should respond with the XClarity Administrator host settings.' do

      response = @virtual_appliance.host_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/interfaces/{interface}' do
    it 'should respond with information about a specific network interface.' do

      response = @virtual_appliance.network_interface_settings("eth0")

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/routes' do
    it 'should respond with all XClarity Administrator routes.' do

      response = @virtual_appliance.route_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/host' do
    it 'should respond with all XClarity Administrator subscriptions.' do

      response = @virtual_appliance.subscriptions

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /nodes' do

    it 'should respond with an array' do
      expect(@client.discover_fan_muxes.class).to eq(Array)
    end

    it 'the response must have one or more nodes' do
      expect(@client.discover_fan_muxes).not_to be_empty
    end

  end

  describe 'GET /nodes/UUID' do

    it 'with includeAttributes' do
      response = @client.fetch_fan_muxes([@uuidArray[0]], @includeAttributes,nil)
        @includeAttributes.map do |attribute|
          expect(response.send(attribute)).not_to be_nil
        end
    end

    it 'with excludeAttributes' do
      response = @client.fetch_fan_muxes([@uuidArray[0]], nil, @excludeAttributes)
        @excludeAttributes.map do |attribute|
          expect(response.send(attribute)).to be_nil
        end
    end
  end

  describe 'GET /nodes' do

    it 'with includeAttributes' do
      response = @client.fetch_fan_muxes(nil,@includeAttributes,nil)
      response.map do |node|
        @includeAttributes.map do |attribute|
          expect(node.send(attribute)).not_to be_nil
        end
      end
    end
    it 'with excludeAttributes' do
      response = @client.fetch_fan_muxes(nil,nil,@excludeAttributes)
      response.map do |node|
        @excludeAttributes.map do |attribute|
          expect(node.send(attribute)).to be_nil
        end
      end
    end

  end
end
