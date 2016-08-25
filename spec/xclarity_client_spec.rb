require 'spec_helper'

describe XClarityClient do
  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  # TODO: Actuall create real tests!
  describe 'GET /aicc' do
    it 'should respond with information about the Lenovo XClarity Administrator' do
      response = 200
      expect(response).to eq(200)
    end
  end

  describe 'GET /aicc/network/ipdisable' do
    it 'should respond with the IPv6 and IPv6 addresses enablement state.' do
      response = 200
      expect(response).to eq(200)
    end
  end
end
