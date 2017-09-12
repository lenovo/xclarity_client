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

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
  end

  before :each do
    @includeAttributes = %w(formFactor inUse)
    @excludeAttributes = %w(formFactor inUse)
    @settingsAttributes = %w(template_type server_template)
    @idArray = @client.discover_configpattern.map { |pattern| pattern.id  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /patterns' do

    it 'should respond with an array' do
      expect(@client.discover_configpattern).not_to be_empty
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_configpattern(nil,@includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |pattern|
          @includeAttributes.map do |attribute|
            expect(pattern.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_configpattern(nil,nil,@excludeAttributes)
        expect(response).not_to be_empty
        response.map do |pattern|
          @excludeAttributes.map do |attribute|
            expect(pattern.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /patterns/ID' do
    context 'without include or exclude' do
      it 'include attributes should not be nil' do
        response = @client.fetch_configpattern([@idArray[0]], nil,nil)
        expect(response).not_to be_empty
        response.map do |pattern|
          @includeAttributes.map do |attribute|
            expect(pattern.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_configpattern([@idArray[0]], @includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |pattern|
          @includeAttributes.map do |attribute|
            expect(pattern.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_configpattern([@idArray[0]], nil, @excludeAttributes)
        expect(response).not_to be_empty
        response.map do |pattern|
          @excludeAttributes.map do |attribute|
            expect(pattern.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /patterns/ID/includeSettings' do
    context 'export configpatterns' do
      it 'should respond with all the settings about the pattern' do
        response = @client.export_configpattern(@idArray[0])
        expect(response).not_to be_empty
        response.map do |pattern|
          @settingsAttributes.map do |attribute|
            expect(pattern.send(attribute)).not_to be_nil
          end
        end
      end
    end
  end

  describe 'POST /patterns' do
    context 'import a config pattern' do
      it 'imports a config patterns' do
        importString = File.read(File.expand_path(__FILE__,"configpattern_input.json"))
        @client.import_configpattern(importString)
        uri = "#{@host}/patterns"
        expect(a_request(:post, uri).with(:body => importString)).to have_been_made
      end
    end
  end

  describe 'POST /patterns/ID' do
    context 'deploy a config pattern' do
      it 'deploys a config pattern' do
        @client.deploy_configpattern(@idArray[0],['B918EDCA1B5F11E2803EBECB82710ADE'],'pending','node')
        uri = "#{@host}/patterns/#{@idArray[0]}"
        expect(a_request(:post, uri).with(:body => JSON.generate(uuid: ['B918EDCA1B5F11E2803EBECB82710ADE'], restart: 'pending'))).to have_been_made
      end
    end
  end

end
