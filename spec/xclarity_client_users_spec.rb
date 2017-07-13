require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
  end

  before :each do
    @includeAttributes = %w(ldapDn loginAttempts)
    @excludeAttributes = %w(ldapDn loginAttempts)
    @idArray = @client.discover_users.map { |user| user.id  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /users' do
    it 'should respond with an array' do
      expect(@client.discover_users).not_to be_empty
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_users(nil,@includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |user|
          @includeAttributes.map do |attribute|
            expect(user.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_users(nil,nil,@excludeAttributes)
        expect(response).not_to be_empty
        response.map do |user|
          @excludeAttributes.map do |attribute|
            expect(user.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /users/ID' do
    context 'without include or exclude' do
      it 'include attributes should not be nil' do
        response = @client.fetch_users([@idArray[0]], nil,nil)
        expect(response).not_to be_empty
        response.map do |user|
          @includeAttributes.map do |attribute|
            expect(user.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_users([@idArray[0]], @includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |user|
          @includeAttributes.map do |attribute|
            expect(user.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_users([@idArray[0]], nil, @excludeAttributes)
        expect(response).not_to be_empty
        response.map do |user|
          @excludeAttributes.map do |attribute|
            expect(user.send(attribute)).to be_nil
          end
        end
      end
    end
  end

end
