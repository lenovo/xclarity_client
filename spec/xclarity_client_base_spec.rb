require 'spec_helper'

describe XClarityClient::XClarityBase do
  context '#responds?' do

    context 'with the correct session using auth_type token' do

      conf = XClarityClient::Configuration.new(
        username:   ENV['LXCA_USERNAME'],
        password:   ENV['LXCA_PASSWORD'],
        host:       ENV['LXCA_HOST'],
        port:       ENV['LXCA_PORT'],
        auth_type:  ENV['LXCA_AUTH_TYPE'],
        verify_ssl: ENV['LXCA_VERIFY_SSL']
      )

      conf.auth_type = 'token'
      host = ENV['LXCA_HOST']
      uri = '/sessions'

      context 'with response 200' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [200, 'OK'])
        end
        it 'should respond with a connection' do
          expect(XClarityClient::XClarityBase.new(conf,'/').conn.class).to eq(Faraday::Connection)
        end
      end

      context 'with response 404' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [404, 'NOT FOUND'])
        end
        it 'should respond with an exception' do
          expect{XClarityClient::XClarityBase.new(conf,'/')}.to raise_error(XClarityClient::Error::ConnectionFailedUnknown)
        end
      end

      context 'with response 403' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [403, 'UNAUTHORIZED'])
        end
        it 'should respond with an exception' do
          expect{XClarityClient::XClarityBase.new(conf,'/')}.to raise_error(XClarityClient::Error::AuthenticationError)
        end
      end
    end
  end
end
