require 'spec_helper'

describe XClarityClient::XClarityCredentialsValidator do
  context '#responds?' do

    context 'with the auth_type = validate' do

      conf = XClarityClient::Configuration.new(
        username:   ENV['LXCA_USERNAME'],
        password:   ENV['LXCA_PASSWORD'],
        host:       ENV['LXCA_HOST'],
        port:       ENV['LXCA_PORT'],
        auth_type:  'validate',
        verify_ssl: ENV['LXCA_VERIFY_SSL']
      )
      uri = '/sessions'
      host = ENV['LXCA_HOST']

      context 'with response 404' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [404, 'NOT FOUND'])
        end
        it 'should respond with an exception' do
          expect{XClarityClient::XClarityCredentialsValidator.new(conf).validate}.to raise_error(XClarityClient::Error::ConnectionFailedUnknown)
        end
      end

      context 'with response 403' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [403, 'UNAUTHORIZED'])
        end
        it 'should respond with an exception' do
          expect{XClarityClient::XClarityCredentialsValidator.new(conf).validate}.to raise_error(XClarityClient::Error::AuthenticationError)
        end
      end
    end
  end
end
