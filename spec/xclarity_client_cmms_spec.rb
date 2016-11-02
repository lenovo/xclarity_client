require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- Uncomment this line if you're using a external connection.

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
    @includeAttributes = %w(accessState backedBy)
    @excludeAttributes = %w(accessState backedBy)
    @uuidArray = @client.discover_cmms.map { |cmm| cmm.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /cmms' do
    it "with includeAttributes params" do
      response = @client.fetch_cmms([@uuidArray[0]], @includeAttributes, nil)
      response.map do |cmm|
        @includeAttributes.map do |attribute|
          expect(cmm.send(attribute)).not_to be_nil
        end
      end
    end
  end

  describe 'GET /cmms/UUID' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_cmms([@uuidArray[0]], @includeAttributes,nil)
        response.map do |cmm|
          @includeAttributes.map do |attribute|
            expect(cmm.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_cmms([@uuidArray[0]], nil, @excludeAttributes)
        response.map do |cmm|
          @excludeAttributes.map do |attribute|
            expect(cmm.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /cmms/UUID,UUID,...,UUID' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_cmms(@uuidArray, @includeAttributes,nil)
        response.map do |cmm|
          @includeAttributes.map do |attribute|
            expect(cmm.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_cmms(@uuidArray, nil, @excludeAttributes)
        response.map do |cmm|
          @excludeAttributes.map do |attribute|
            expect(cmm.send(attribute)).to be_nil
          end
        end
      end
    end

  end

  describe 'GET /cmms' do

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_cmms(nil,@includeAttributes,nil)
        response.map do |cmm|
          @includeAttributes.map do |attribute|
            expect(cmm.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_cmms(nil,nil,@excludeAttributes)
        response.map do |cmm|
          @excludeAttributes.map do |attribute|
            expect(cmm.send(attribute)).to be_nil
          end
        end
      end
    end
  end
end
