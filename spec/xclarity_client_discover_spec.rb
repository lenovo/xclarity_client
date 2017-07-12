require 'spec_helper'

describe XClarityClient::Discover do
  context '#responds?' do
    context 'without the correct appliance IPAddress' do
      it 'should return false' do
        res = XClarityClient::Discover.responds?(Faker::Internet.ip_v4_address, Faker::Number.number(4))
        expect(res).not_to be_truthy
      end
    end

    context 'with the correct appliance IPAddress' do
      before do
        @port = Faker::Number.number(4)
        @address = URI('https://' + Faker::Internet.ip_v4_address + ':' + @port)
        WebMock.allow_net_connect!
        stub_request(:get, File.join(@address.to_s, '/aicc')).to_return(:status => [200, 'OK'])
      end

      it 'should return true' do
        res = XClarityClient::Discover.responds?(@address.host, @port)
        expect(res).to be_truthy
      end
    end
  end
end
