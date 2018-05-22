require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :port     => ENV['LXCA_PORT'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )
    @host = ENV['LXCA_HOST']
    @client = XClarityClient::Client.new(conf)
  end

  before :each do
    @includeAttributes = %w(accessState attachedNodes)
    @excludeAttributes = %w(accessState attachedNodes)
    @uuidArray = @client.discover_switches.map { |switch| switch.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /switches' do
    it 'should respond with an array' do
      expect(@client.discover_switches.class).to eq(Array)
    end

    context "with includeAttributes" do
      before :each do
        @response = @client.fetch_switches(nil,@includeAttributes,nil)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @includeAttributes.map do |attribute|
            expect(switch.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context "with excludeAttributes" do
      before :each do
        @response = @client.fetch_switches(nil,nil,@excludeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @excludeAttributes.map do |attribute|
            expect(switch.send(attribute)).to satisfy("atribute must be nil or empty") do |v|
              v == nil || v.empty?
            end
          end
        end
      end
    end
  end

  describe 'GET /switches/UUID,UUID,...,UUID' do

    context "with includeAttributes" do
      before :each do
        @response = @client.fetch_switches(@uuidArray, @includeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @includeAttributes.map do |attribute|
            expect(switch.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context "with excludeAttributes" do
      before :each do
        @response = @client.fetch_switches(@uuidArray, nil, @excludeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @excludeAttributes.map do |attribute|
            expect(switch.send(attribute)).to satisfy("atribute must be nil or empty") do |v|
              v == nil || v.empty?
            end
          end
        end
      end
    end
  end

  context 'do Power operations' do
    it 'should fail without the uuid' do
      expect { @client.power_cycle_soft_switch }.to raise_error('Invalid target or power state requested')
    end

    it 'should do the power cycle soft request successfully' do
      response = @client.power_cycle_soft_switch(@uuidArray.first)
      uri = "#{@host}/switches/#{@uuidArray.first}"
      request_body = { 'body' => { 'powerState' => 'powerCycleSoft' } }
      expect(a_request(:put, uri).with(request_body)).to have_been_made
      expect(response.status).to eq(200)
    end
  end
end
