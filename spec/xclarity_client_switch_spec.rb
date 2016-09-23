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

  describe 'GET /switches' do

    it 'should respond with an array' do
      expect(@client.discover_switches.class).to eq(Array)
    end

    it 'the response must have one or more switches' do
      expect(@client.discover_switches).not_to be_empty
    end

  end

  describe 'GET /switches/UUID,UUID,...,UUID with includeAttributes and excludeAttributes' do
    before :each do
      @includeAttributes = %w(accessState attachedNodes)
      @excludeAttributes = %w(accessState attachedNodes)
      @uuidArray = @client.discover_switches.map { |switch| switch.uuid  }
    end

    it 'GET /switches/UUID with includeAttributes' do

      response = @client.fetch_switches(@uuidArray, @includeAttributes)
      response.map do |switch|
        @includeAttributes.map do |attribute|
          expect(switch.send(attribute)).not_to be_nil
        end
      end

    end
    it 'GET /switches/UUID with excludeAttributes' do
      response = @client.fetch_switches(@uuidArray, nil, @excludeAttributes)
      response.map do |switch|
        @excludeAttributes.map do |attribute|
          expect(switch.send(attribute)).to be_nil
        end
      end
    end
    it 'GET /switches just with includeAttributes' do
      response = @client.fetch_switches(nil,@includeAttributes,nil)
      response.map do |switch|
        @includeAttributes.map do |attribute|
          expect(switch.send(attribute)).not_to be_nil
        end
      end
    end
    it 'GET /switches just with excludeAttributes' do
      response = @client.fetch_switches(nil,nil,@excludeAttributes)
      response.map do |switch|
        @excludeAttributes.map do |attribute|
          expect(switch.send(attribute)).to be_nil
        end
      end
    end
  end

  describe 'GET /switches/UUID,UUID,...,UUID' do

    it 'to multiples uuid, should return two or more switches' do
      uuidArray = @client.discover_switches.map { |switch| switch.uuid  }
      expect(uuidArray.length).to be >= 2
    end
  end
end
