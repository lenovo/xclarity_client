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

    @host = ENV['LXCA_HOST']
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /unmanageRequest/jobs/<job_id>' do
    it 'should return a non empty array' do
      response = @client.fetch_unmanage_request('4685')
      expect(response).not_to be_empty
      my_hash = Hash.new
      response.map do |res|
        res.instance_variables.each do |attr|
          my_hash[attr.to_s.delete("@")] = res.instance_variable_get attr
        end
      end

      uri = URI.parse("https://example.com/unmanageRequest/jobs/4685")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      data = http.get(uri.request_uri)

      expect(JSON.parse(my_hash.to_json).sort.eql?(JSON.parse(data.body).sort)).to be true
    end
  end

  describe 'POST /unmanageRequest' do
    context 'Unmanage an endpoint' do
      it 'Create a unmanage job to unmanage the said endpoint' do
        @client.unmanage_discovered_devices([{"ipAddresses":["10.240.72.172"],"type":"Chassis","uuid":"46920C143355486F97C19A34ABC7D746"}],"True")
        uri = "#{@host}/unmanageRequest"
        expect(a_request(:post, uri)).to have_been_made
      end
    end
  end

end
