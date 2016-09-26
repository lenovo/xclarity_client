require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect!

    conf_blueprint = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://example.com'
    )

    @client = XClarityClient::Client.new(conf_blueprint)

    @includeAttributes = %w(accessState activationKeys)
    @excludeAttributes = %w(accessState activationKeys)

    @uuidArray = @client.discover_chassis.map { |chassi| chassi.uuid  }
  end

  describe 'GET /chassis' do
    it "with includeAttributes params" do
      response = @client.fetch_chassis([@uuidArray[0]], @includeAttributes, nil)
      response.map do |chassi|
        @includeAttributes.map do |attribute|
          expect(chassi.send(attribute)).not_to be_nil
        end
      end
    end
  end

  describe 'GET /chassis/UUID' do

    it 'with includeAttributes' do
      response = @client.fetch_chassis([@uuidArray[0]], @includeAttributes,nil)
      response.map do |chassi|
        @includeAttributes.map do |attribute|
          expect(chassi.send(attribute)).not_to be_nil
        end
      end

    end

    it 'with excludeAttributes' do
      response = @client.fetch_chassis([@uuidArray[0]], nil, @excludeAttributes)
      response.map do |chassi|
        @excludeAttributes.map do |attribute|
          expect(chassi.send(attribute)).to be_nil
        end
      end
    end
  end

  describe 'GET /chassis/UUID,UUID,...,UUID' do

    it 'to multiples uuid, should return two or more chassis' do
      uuidArray = @client.discover_chassis.map { |chassi| chassi.uuid  }
      expect(uuidArray.length).to be >= 2
    end

    it 'with includeAttributes' do
      response = @client.fetch_chassis(@uuidArray, @includeAttributes,nil)
      response.map do |chassi|
        @includeAttributes.map do |attribute|
          expect(chassi.send(attribute)).not_to be_nil
        end
      end
    end

    it 'with excludeAttributes' do
      response = @client.fetch_chassis(@uuidArray, nil, @excludeAttributes)
      response.map do |chassi|
        @excludeAttributes.map do |attribute|
          expect(chassi.send(attribute)).to be_nil
        end
      end
    end
  end

  describe 'GET /chassis' do

    it 'with includeAttributes' do
      response = @client.fetch_chassis(nil,@includeAttributes,nil)
      response.map do |chassi|
        @includeAttributes.map do |attribute|
          expect(chassi.send(attribute)).not_to be_nil
        end
      end
    end
    it 'with excludeAttributes' do
      response = @client.fetch_chassis(nil,nil,@excludeAttributes)
      response.map do |chassi|
        @excludeAttributes.map do |attribute|
          expect(chassi.send(attribute)).to be_nil
        end
      end
    end
  end
end
