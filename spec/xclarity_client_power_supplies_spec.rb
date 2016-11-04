require 'spec_helper'

describe XClarityClient do
  before :all do
    WebMock.allow_net_connect! # -- uncomment this line if you're testing with external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
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
      response = @client.fetch_power_supplies(@uuidArray, @includeAttributes, nil)
      response.map do |power_supply|
        @includeAttributes.map do |attribute|
          expect(power_supply.send(attribute)).not_to be_nil
        end
      end

    end

    it 'with excludeAttributes' do
      response = @client.fetch_power_supplies(@uuidArray, nil, @excludeAttributes)
      response.map do |power_supply|
        @excludeAttributes.map do |attribute|
          expect(power_supply.send(attribute)).to be_nil
        end
      end
    end
  end
end
