require 'spec_helper'

describe XClarityClient do
  before :all do
    # -- The next line should be uncommented
    # if you're using external mock test
    WebMock.allow_net_connect!

    conf = XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      port:       ENV['LXCA_PORT'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @include_attributes = %w(access_state description)
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /config/target/ID' do
    it 'should respond with a array' do
      response = @client.fetch_configtarget(['65'], @include_attributes, nil)
      response.map do |target|
        @include_attributes.map do |attribute|
          expect(target.send(attribute)).not_to be_nil
        end
      end
    end
  end

end
