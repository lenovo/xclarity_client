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

  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /updateRepositories/firmware' do

    context 'without any options' do
      it 'should throw an error' do
        expect {@client.discover_update_repo}.to raise_error(RuntimeError, 'Option key must be provided for update_repo resource')
      end
    end

    context 'with option key and an invalid value' do
      it 'should throw an error' do
        expect {@client.discover_update_repo({"key":"Stopped"}).class}.to raise_error(RuntimeError, 'The value for option key should be one of these : supportedMts, lastRefreshed, size, importDir, publicKeys, updates, updatesByMt, updatesByMtByComp')
      end
    end

    context 'with option key and value set to supportedMts' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"supportedMts"})).not_to be_empty
      end
    end

    context 'with option key and value set to lastRefreshed' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"lastRefreshed"})).not_to be_empty
      end
    end

    context 'with option key and value set to size' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"size"})).not_to be_empty
      end
    end

    context 'with option key and value set to importDir' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"importDir"})).not_to be_empty
      end
    end

    context 'with option key and value set to publicKeys' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"publicKeys"})).not_to be_empty
      end
    end

    context 'with option key and value set to updates' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updates"})).not_to be_empty
      end
    end

    context 'with option key and value set to updatesByMt' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updatesByMt"})).not_to be_empty
      end
    end

    context 'with option key and value set to updatesByMtByComp' do
      it 'should return an array' do
        expect(@client.discover_update_repo({"key":"updatesByMtByComp"})).not_to be_empty
      end
    end

  end
end
