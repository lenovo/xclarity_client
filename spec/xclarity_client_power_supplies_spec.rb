require 'spec_helper'

describe XClarityClient do
  before :all do
    # WebMock.allow_net_connect! # -- uncomment this line if you're testing with external mock.

    conf = XClarityClient::Configuration.new(
      :username => 'admin',
      :password => 'pass',
      :host     => 'http://example.com'
    )

    @client = XClarityClient::Client.new(conf)

    @includeAttributes = %w(description dataHandle)
    @excludeAttributes = %w(description dataHandle)
  end

  before :each do
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

    it 'with includeAttributes' do
      response = @client.fetch_power_supplies(nil, @includeAttributes, nil)
      response.map do |powerSupply|
        @includeAttributes.map do |attribute|
          expect(powerSupply.send(attribute)).not_to be_nil
        end
      end
    end

    it 'with excludeAttributes' do
      response = @client.fetch_power_supplies(nil, nil, @excludeAttributes)
      response.map do |powerSupply|
        @excludeAttributes.map do |attribute|
          expect(powerSupply.send(attribute)).to be_nil
        end
      end
    end
  end

  describe 'GET /powerSupplies/UUID' do
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
