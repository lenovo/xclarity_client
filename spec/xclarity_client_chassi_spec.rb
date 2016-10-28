require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection with mock

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
        response = @client.fetch_chassis([@uuidArray[0]], @includeAttributes,nil)
        response.map do |chassi|
          @includeAttributes.map do |attribute|
            expect(chassi.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_chassis([@uuidArray[0]], nil, @excludeAttributes)
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
end
