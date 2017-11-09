require 'spec_helper'

describe XClarityClient::XClarityBase do
  context '#responds?' do

    context 'with the correct connection using auth_type basic_auth' do

      conf = XClarityClient::Configuration.new(
        username:   ENV['LXCA_USERNAME'],
        password:   ENV['LXCA_PASSWORD'],
        host:       ENV['LXCA_HOST'],
        port:       ENV['LXCA_PORT'],
        auth_type:  'basic_auth',
        verify_ssl: ENV['LXCA_VERIFY_SSL']
      )

      uri = '/'
      host = ENV['LXCA_HOST']


      context 'with response 200' do
        before do
          WebMock.allow_net_connect!
          stub_request(:post, File.join(host, uri)).to_return(:status => [200, 'OK'])
        end
        it 'should respond with a connection' do
          expect(XClarityClient::XClarityBase.new(conf, uri).conn.class).to eq(Faraday::Connection)
        end
      end
    end
  end
end
