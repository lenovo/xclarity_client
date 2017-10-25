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
    :verify_ssl => ENV['LXCA_VERIFY_SSL'],
    :user_agent_label => ENV['LXCA_USER_AGENT_LABEL']
    )

    @client = XClarityClient::Client.new(conf)
    @user_agent = ENV['LXCA_USER_AGENT_LABEL']
    @host = ENV['LXCA_HOST']
  end

  before :each do
    @includeAttributes = %w(rackId unit)
    @excludeAttributes = %w(rackId unit)
    @idArray = @client.discover_config_profile.map { |profile| profile.id  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /profiles' do

    it 'should respond with an array' do
      expect(@client.discover_config_profile).not_to be_empty
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_config_profile(nil,@includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |profile|
          @includeAttributes.map do |attribute|
            expect(profile.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_config_profile(nil,nil,@excludeAttributes)
        expect(response).not_to be_empty
        response.map do |profile|
          @excludeAttributes.map do |attribute|
            expect(profile.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /profiles/ID' do
    context 'without include or exclude' do
      it 'include attributes should not be nil' do
        response = @client.fetch_config_profile([@idArray[0]], nil,nil)
        expect(response).not_to be_empty
        response.map do |profile|
          @includeAttributes.map do |attribute|
            expect(profile.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_config_profile([@idArray[0]], @includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |profile|
          @includeAttributes.map do |attribute|
            expect(profile.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_config_profile([@idArray[0]], nil, @excludeAttributes)
        expect(response).not_to be_empty
        response.map do |profile|
          @excludeAttributes.map do |attribute|
            expect(profile.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'POST /profiles/ID' do
    context 'activate the profile' do
      it 'activates the profile' do
        @client.activate_config_profile(@idArray[0],"46920C143355486F97C19A34ABC7D746_bay10", "immediate")
        uri = "#{@host}/profiles/#{@idArray[0]}"
        request_body = { 'body' => {'restart' => 'immediate', 'uuid' => '46920C143355486F97C19A34ABC7D746_bay10'} }
        expect(a_request(:post, uri).with(request_body)).to have_been_made
      end
    end
  end

  describe 'POST /profiles/unassign/ID' do
    context 'unassign the profile' do
      it 'unassigns the profile' do
        @client.unassign_config_profile(@idArray[0],"False", "False", "False")
        uri = "#{@host}/profiles/unassign/#{@idArray[0]}"
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        puts user_agent
        expect(a_request(:post, uri).with(:body => JSON.generate(force: 'False', powerDownITE: 'False', resetIMM: 'False'), :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=> user_agent})).to have_been_made
      end
    end
  end

  describe 'PUT /profiles/ID' do
    context 'rename the profile' do
      it 'renames the profile' do
        @client.rename_config_profile(@idArray[0],"New name")
        uri = "#{@host}/profiles/#{@idArray[0]}"
        request_body = { 'body' => {'profileName' => 'New name'} }
        expect(a_request(:put, uri).with(request_body)).to have_been_made
      end
    end
  end

  describe 'DELETE /profiles/ID' do
    context 'delete the profile' do
      it 'deletes the profile' do
        @client.delete_config_profile(@idArray[0])
        uri = "#{@host}/profiles/#{@idArray[0]}"
        expect(a_request(:delete, uri)).to have_been_made
      end
    end
  end

end
