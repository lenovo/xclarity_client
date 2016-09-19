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
    #
    # @includeAttributes = %w(description dataHandle)
    # @excludeAttributes = %w(description dataHandle)
    # @uuidArray = @client.discover_power_supplies.map { |chassi| chassi.uuid  }
  end

  it "has a version number" do
    expect(XClarityClient::VERSION).not_to be nil
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


  describe 'GET /power_supplies' do

    it 'should respond with an array' do
      expect(@client.discover_power_supplies.class).to eq(Array)
    end

    it 'the response must have one or more nodes' do
      expect(@client.discover_power_supplies).not_to be_empty
    end
  end

  # describe 'GET /power_supplies/UUID' do
  #
  #   it 'with includeAttributes' do
  #     response = @client.fetch_power_supplies([@uuidArray[0]], @includeAttributes,nil)
  #     response.map do |power_supply|
  #       @includeAttributes.map do |attribute|
  #         expect(power_supply.send(attribute)).not_to be_nil
  #       end
  #     end
  #
  #   end
  #
  #   it 'with excludeAttributes' do
  #     response = @client.fetch_power_supplies([@uuidArray[0]], nil, @excludeAttributes)
  #     response.map do |power_supply|
  #       @excludeAttributes.map do |attribute|
  #         expect(power_supply.send(attribute)).to be_nil
  #       end
  #     end
  #   end
  # end
end
