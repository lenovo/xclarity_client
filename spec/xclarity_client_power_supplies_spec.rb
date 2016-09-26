require 'spec_helper'

describe XClarityClient do
  before :all do
    WebMock.allow_net_connect!

    conf_blueprint = XClarityClient::Configuration.new(
      :username => 'admin',
      :password => 'pass',
      :host     => 'http://example.com'
    )

    @virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf_blueprint)
    @client = XClarityClient::Client.new(conf_blueprint)

    @includeAttributes = %w(description dataHandle)
    @excludeAttributes = %w(description dataHandle)
    @uuidArray = @client.discover_power_supplies.map { |power_supply| power_supply.uuid  }
  end

  it "has a version number" do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /power_supplies' do

    it 'should respond with an array' do
      expect(@client.discover_power_supplies.class).to eq(Array)
    end

    it 'the response must have one or more nodes' do
      expect(@client.discover_power_supplies).not_to be_empty
    end
  end

  describe 'GET /power_supplies/UUID' do

    it 'with includeAttributes' do
      response = @client.fetch_power_supplies([@uuidArray[0]], @includeAttributes, nil)
      @includeAttributes.map do |attribute|
        expect(response.send(attribute)).not_to be_nil
      end
    end

    it 'with excludeAttributes' do
      response = @client.fetch_power_supplies([@uuidArray[0]], nil, @excludeAttributes)
      @excludeAttributes.map do |attribute|
        expect(response.send(attribute)).to be_nil
      end
    end
  end
end
