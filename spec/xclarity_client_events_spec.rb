require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- This line should be uncommented if you're using external mock test

    conf = XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      port:       ENV['LXCA_PORT'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @includeAttributes = %w(accessState activationKeys)
    @excludeAttributes = %w(accessState activationKeys)
  end

  before :each do
    @uuidArray = @client.discover_nodes.map { |node| node.uuid  }
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

    context 'attributes included in the version 2.0' do
      it 'getting new attributes' do
        response = @client.discover_events
        response.each do |event|
          event.descriptionArgs.should_not be_nil
          event.userActionArgs.should_not be_nil
          event.groupUUID.should_not be_nil
          event.groupName.should_not be_nil
        end
      end
    end

    context 'with opts parameters' do
      context 'where the opts is only sort' do

        opts = {"sort" => "cn"}
        puts opts

        it 'the elemented used to sort should be greater or equal to second element on response' do

          olderValue = nil


          response = @client.fetch_events(opts)

          response.map do |event|
            if olderValue == nil
              olderValue = event.send opts.first[1]
              next
            end

            expect((event.send opts.first[1]).to_i).to be > olderValue.to_i
            olderValue = event.send opts.first[1]

          end
        end
      end


      context 'where the opts is only filterWith' do

        opts = { 'filterWith' => '{"filterType":"FIELDNOTREGEXAND","fields":[{"operation":"GT","field":"cn","value":"242328"}]}'}
        oldValue =242328
        filed = "cn"
        puts opts

        it 'the element used to filterWith should be greater than it self on response OR the response will be none' do

          response = @client.fetch_events(opts)

          response.map do |event|
            expect((event.send filed).to_i).to be > oldValue
          end
        end
      end

    end
  end

end
