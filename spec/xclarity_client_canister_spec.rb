require 'spec_helper'

describe XClarityClient do

  before :all do
    # WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection or mock.

    conf = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://example.com'
    )

    @client = XClarityClient::Client.new(conf)
  end

  before :each do
    @includeAttributes = %w(memorySlots)
    @excludeAttributes = %w(memorySlots)
    @uuidArray = @client.discover_canisters.map { |canister| canister.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /canisters' do

    it 'should respond with an array' do
      expect(@client.discover_canisters.class).to eq(Array)
    end

    it 'response should have one or more canisters' do
      expect(@client.discover_canisters).not_to be_empty
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_canisters(nil,@includeAttributes,nil)
        response.map do |canister|
          @includeAttributes.map do |attribute|
            expect(canister.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_canisters(nil,nil,@excludeAttributes)
        response.map do |canister|
          @excludeAttributes.map do |attribute|
            expect(canister.send(attribute)).to be_nil
          end
        end
      end
    end

  end

  describe 'GET /canisters/UUID' do

    it 'should return two or more canisters' do
      uuidArray = @client.discover_canisters.map { |canister| canister.uuid  }
      expect(uuidArray.length).to be >= 2
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_canisters(@uuidArray[0], @includeAttributes,nil)
        response.map do |canister|
          @includeAttributes.map do |attribute|
          expect(canister.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_canisters(@uuidArray[0], nil, @excludeAttributes)
        response.map do |canister|
          @excludeAttributes.map do |attribute|
          expect(canister.send(attribute)).to be_nil
          end
        end
      end
    end
  end
end
