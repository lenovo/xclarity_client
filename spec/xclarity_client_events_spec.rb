require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection or mock.

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

    @uuidArray = @client.discover_events.map { |event| event.eventID  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /events' do

    it 'should respond with an array' do
      expect(@client.discover_events.class).to eq(Array)
    end

    context 'with opts parameters' do
      context 'where the opts is only sort' do

        opts = {"sort" => "cn"}
        puts opts

        it 'the elemented used to sort should be greater or equal to second element' do

          olderValue = nil
          response = @client.fetch_events(opts)

          response.map do |event|
            if olderValue == nil
              olderValue = event.send opts.first[1]
              next
            end

            expect(event.send opts.first[1]).to be >= olderValue
            olderValue = event.send opts.first[1]

          end
        end
      end
    end
  end

end
