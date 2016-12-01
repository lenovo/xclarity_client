require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection or mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)
  end

  before :each do
    @includeAttributes = %w(memorySlots)
    @excludeAttributes = %w(memorySlots)
    @uuidArray = @client.discover_events.map { |event| event.eventID  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /events' do

    it 'should respond with an array' do
      expect(@client.discover_events.class).to eq(Array)
    end

    context 'with parameters' do
      it 'include attributes should not be nil' do
        response = @client.discover_events(type)
        response.map do |events|
          @includeAttributes.map do |attribute|
            expect(events.send(attribute)).not_to be_nil
          end
        end
      end
    end
  end

end
