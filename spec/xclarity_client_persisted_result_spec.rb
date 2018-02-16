require 'spec_helper'

describe XClarityClient do

  let(:conf) {
    XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      port:       ENV['LXCA_PORT'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )
  }

  let(:client) { XClarityClient::Client.new conf }
  let(:persisted_result) { client.fetch_compliance_policies }

  context 'GET /persistedResult with response 200' do

    uri = '/sessions'
    host = ENV['LXCA_HOST']
    id = "#{rand(999)}"
    body = "{\"messages\":[{\"id\":\"#{id}\"}]}"

    before do
      WebMock.allow_net_connect!
      stub_request(:post, File.join(host, uri)).to_return(:status => [200, 'OK'], :body => body )
      stub_request(:delete, File.join(host, uri, id)).to_return(:status => [200, 'OK'])
    end

    it 'should not be nil' do
      expect(persisted_result).to_not be_nil
    end

    it 'should has the xITEs' do
      expect(persisted_result.first.xITEs).to_not be_nil
    end
  end
end
