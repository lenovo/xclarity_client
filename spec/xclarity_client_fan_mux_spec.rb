
require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection.

    conf = XClarityClient::Configuration.new(
    :username => ENV['USERNAME_VALUE'],
    :password => ENV['PASSWORD_VALUE'],
    :host     => ENV['HOST_VALUE'],
    :auth_type => ENV['AUTH_TYPE_VALUE'],
    :verify_ssl => ENV['VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)
  end

  before :each do
    @includeAttributes = %w(productName)
    @excludeAttributes = %w(productName)
    @uuidArray = @client.discover_fan_muxes.map { |fan_mux| fan_mux.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /fanMuxes' do

    it 'should respond with an array' do
      expect(@client.discover_fan_muxes.class).to eq(Array)
    end

    it 'the response must have one or more Fan Muxes' do
      expect(@client.discover_fan_muxes).not_to be_empty
    end

    context 'with includeAttributes' do
      #TODO: Uncomment this block when the issue from LXCA API will be fixed
=begin
      it 'include attributes should not be nil' do
        response = @client.fetch_fan_muxes(nil,@includeAttributes,nil)
        response.map do |fan_mux|
          @includeAttributes.map do |attribute|
            expect(fan_mux.send(attribute)).not_to be_nil
          end
        end
      end
=end
    end
    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_fan_muxes(nil,nil,@excludeAttributes)
        response.map do |fan_mux|
          @excludeAttributes.map do |attribute|
            expect(fan_mux.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /fanMuxes/UUID' do

    context 'with includeAttributes' do
      #TODO: Uncomment this block when the issue from LXCA API will be fixed
=begin
      it 'include attributes should be nil' do
        response = @client.fetch_fan_muxes([@uuidArray[0]], @includeAttributes,nil)
        @includeAttributes.map do |attribute|
          expect(response.send(attribute)).not_to be_nil
        end
      end
=end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_fan_muxes([@uuidArray[0]], nil, @excludeAttributes)
        @excludeAttributes.map do |attribute|
          expect(response.send(attribute)).to be_nil
        end
      end
    end
  end
end
