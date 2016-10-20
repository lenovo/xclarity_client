require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- This line should be uncommented if you're using external mock test

    conf = XClarityClient::Configuration.new(
    :username => ENV['USERNAME_VALUE'],
    :password => ENV['PASSWORD_VALUE'],
    :host     => ENV['HOST_VALUE'],
    :auth_type => ENV['AUTH_TYPE_VALUE']
    )

    @client = XClarityClient::Client.new(conf)

    @includeAttributes = %w(storageList height)
    @excludeAttributes = %w(storageList height)
  end

  before :each do
    @uuidArray = @client.discover_cabinet.map { |cabinet| cabinet.UUID  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /cabinet' do

    it 'should respond with an array' do
      expect(@client.discover_cabinet.class).to eq(Array)
    end

    it 'the response must have one or more cabinet' do
      expect(@client.discover_cabinet).not_to be_empty
    end

    context 'with includeAttributes' do
      it 'required attributes should not be nil' do
        response = @client.fetch_cabinet(nil,@includeAttributes,nil)
        response.map do |cabinet|
          @includeAttributes.map do |attribute|
            expect(cabinet.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'excluded attributes should be nil' do
        response = @client.fetch_cabinet(nil,nil,@excludeAttributes)
        response.map do |cabinet|
          @excludeAttributes.map do |attribute|
            expect(cabinet.send(attribute)).to be_nil
          end
        end
      end
    end

  end

  describe 'GET /cabinet/UUID' do
    context 'with include attributes' do
      it 'required attributes should not be nil' do
        response = @client.fetch_cabinet([@uuidArray[0]], @includeAttributes,nil)
        response.map do |cabinet|
          @includeAttributes.map do |attribute|
            expect(cabinet.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'excluded attributes should to be nil' do
        response = @client.fetch_cabinet([@uuidArray[0]], nil, @excludeAttributes)
        response.map do |cabinet|
          @excludeAttributes.map do |attribute|
            expect(cabinet.send(attribute)).to be_nil
          end
        end
      end
    end
  end
end
