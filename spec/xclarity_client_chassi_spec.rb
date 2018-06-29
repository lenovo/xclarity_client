require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection with mock

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
    @includeAttributes = %w(type)
    @excludeAttributes = %w(accessState activationKeys)
    @uuidArray = @client.discover_chassis.map { |chassi| chassi.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /chassis' do
    it "should response 200 code" do
      response = @client.discover_chassis
      expect(response).not_to be_empty
    end
  end

  describe 'GET /chassis/UUID' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_chassis(@uuidArray, @includeAttributes,nil)
        response.map do |chassi|
          @includeAttributes.map do |attribute|
            expect(chassi.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_chassis(@uuidArray, nil, @excludeAttributes)
        response.map do |chassi|
          @excludeAttributes.map do |attribute|
            expect(chassi.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /chassis/UUID,UUID,...,UUID' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_chassis(@uuidArray, @includeAttributes,nil)
        response.map do |chassi|
          @includeAttributes.map do |attribute|
            expect(chassi.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_chassis(@uuidArray, nil, @excludeAttributes)
        response.map do |chassi|
          @excludeAttributes.map do |attribute|
            expect(chassi.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /chassis' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_chassis(nil,@includeAttributes,nil)
        response.map do |chassi|
          @includeAttributes.map do |attribute|
            expect(chassi.send(attribute)).not_to be_nil
          end
        end
      end
    end
    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_chassis(nil,nil,@excludeAttributes)
        response.map do |chassi|
          @excludeAttributes.map do |attribute|
            expect(chassi.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'Change LED state' do
    it 'turns on the blinking location led' do
      response = @client.blink_loc_led_chassis(@uuidArray[0])
      uri = "#{@host}/chassis/#{@uuidArray[0]}"
      request_body = { 'body' => { 'leds' => [{ 'name'  => 'Location',
                    'state' => 'Blinking' }] } }
      expect(a_request(:put, uri).with(request_body)).to have_been_made
      expect(response.status).to eq(200)
    end

    it 'turns off the location led' do
      response = @client.turn_off_loc_led_chassis(@uuidArray[0])
      uri = "#{@host}/chassis/#{@uuidArray[0]}"
      request_body = { 'body' => { 'leds' => [{ 'name'  => 'Location',
                    'state' => 'Off' }] } }
      expect(a_request(:put, uri).with(request_body)).to have_been_made
      expect(response.status).to eq(200)
    end

    it 'turns on the location led' do
      response = @client.turn_on_loc_led_chassis(@uuidArray[0])
      uri = "#{@host}/chassis/#{@uuidArray[0]}"
      request_body = { 'body' => { 'leds' => [{ 'name'  => 'Location',
                    'state' => 'On' }] } }
      expect(a_request(:put, uri).with(request_body)).to have_been_made
      expect(response.status).to eq(200)
    end
  end
end
