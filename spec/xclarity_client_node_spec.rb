require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! # -- This line should be uncommented if you're using external mock test

    conf = XClarityClient::Configuration.new(
    :username => ENV['USERNAME_VALUE'],
    :password => ENV['PASSWORD_VALUE'],
    :host     => ENV['HOST_VALUE'],
    :auth_type => ENV['AUTH_TYPE_VALUE'],
    :verify_ssl => ENV['VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @includeAttributes = %w(accessState activationKeys)
    @excludeAttributes = %w(accessState activationKeys)
  end

  before :each do
    @uuidArray = @client.discover_nodes.map { |node| node.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /nodes' do

    it 'should respond with an array' do
      expect(@client.discover_nodes.class).to eq(Array)
    end

  end

  describe 'GET /nodes/UUID' do
    context 'with include attributes' do
      it 'required attributes should not be nil' do
        response = @client.fetch_nodes(@uuidArray, @includeAttributes,nil)
        response.map do |node|
          @includeAttributes.map do |attribute|
            expect(node.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'excluded attributes should to be nil' do
        response = @client.fetch_nodes(@uuidArray, nil, @excludeAttributes)
        response.map do |node|
          @excludeAttributes.map do |attribute|
            expect(node.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /nodes/UUID,UUID,...,UUID' do

    context 'with includeAttributes' do
      it 'required attributes shoud not be nil ' do
        response = @client.fetch_nodes(@uuidArray, @includeAttributes,nil)
        response.map do |node|
          @includeAttributes.map do |attribute|
            expect(node.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'excluded attributes shoud to be nil' do
        response = @client.fetch_nodes(@uuidArray, nil, @excludeAttributes)
        response.map do |node|
          @excludeAttributes.map do |attribute|
            expect(node.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /nodes' do

    context 'with includeAttributes' do
      it 'required attributes should not be nil' do
        response = @client.fetch_nodes(nil,@includeAttributes,nil)
        response.first do |node|
          @includeAttributes.map do |attribute|
            expect(node.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'excluded attributes should be nil' do
        response = @client.fetch_nodes(nil,nil,@excludeAttributes)
        response.map do |node|
          @excludeAttributes.map do |attribute|
            expect(node.send(attribute)).to be_nil
          end
        end
      end
    end
  end
end
