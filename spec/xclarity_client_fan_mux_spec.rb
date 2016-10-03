
require 'spec_helper'

describe XClarityClient do

  before :all do
    # WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection.

    conf = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://example.com'
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

  describe 'GET /nodes' do

    it 'should respond with an array' do
      expect(@client.discover_fan_muxes.class).to eq(Array)
    end

    it 'the response must have one or more nodes' do
      expect(@client.discover_fan_muxes).not_to be_empty
    end

    context 'with includeAttributes' do
=begin
      it 'include attributes should not be nil' do
        response = @client.fetch_fan_muxes(nil,@includeAttributes,nil)
        response.map do |node|
          @includeAttributes.map do |attribute|
            expect(node.send(attribute)).not_to be_nil
          end
        end
      end
=end
    end
    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_fan_muxes(nil,nil,@excludeAttributes)
        response.map do |node|
          @excludeAttributes.map do |attribute|
            expect(node.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /nodes/UUID' do

    context 'with includeAttributes' do
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
