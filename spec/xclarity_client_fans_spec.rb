require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

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
    @includeAttributes = %w(cmmHealthState)
    @excludeAttributes = %w(cmmHealthState)
    @uuidArray = @client.discover_fans.map { |fan| fan.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /fans' do

    it 'should respond with an array' do
      expect(@client.discover_fans.class).to eq(Array)
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_fans(nil,@includeAttributes,nil)
        response.map do |fan|
          @includeAttributes.map do |attribute|
            expect(fan.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_fans(nil,nil,@excludeAttributes)
        response.map do |fan|
          @excludeAttributes.map do |attribute|
            expect(fan.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /fans/UUID' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_fans(@uuidArray, @includeAttributes,nil)
        response.map do |fan|
          @includeAttributes.map do |attribute|
            expect(fan.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_fans(@uuidArray, nil, @excludeAttributes)
        response.map do |fan|
          @excludeAttributes.map do |attribute|
            expect(fan.send(attribute)).to be_nil
          end
        end
      end
    end
  end
end
