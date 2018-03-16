require 'spec_helper'

describe XClarityClient do
  before do
    conf = XClarityClient::Configuration.new(
      :username   => ENV['LXCA_USERNAME'],
      :password   => ENV['LXCA_PASSWORD'],
      :host       => ENV['LXCA_HOST'],
      :port       => ENV['LXCA_PORT'],
      :auth_type  => ENV['LXCA_AUTH_TYPE'],
      :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)
    @req_stub = stub_request(:get, "#{ENV['LXCA_HOST']}/remoteaccess/remoteControl?uuid=#{uuid}")
  end

  describe '#remote_control' do
    subject { @client.remote_control(uuid) }

    let(:uuid) { '1234' }

    context 'when the API responds with Content-Type application/json' do
      before do
        @req_stub.to_return(:body => {:url => 'my_url'}.to_json, :headers => { 'Content-Type' => 'other;application/json;other' })
      end

      it { is_expected.to have_attributes(:type => :url, :resource => 'my_url') }
    end

    context 'when the API responds with Content-Type application/x-java-jnlp-file' do
      before do
        @req_stub.to_return(:body => '<my_jnlp></my_jnlp>', :headers => { 'Content-Type' => 'other;application/x-java-jnlp-file;other' })
      end

      it { is_expected.to have_attributes(:type => :java_jnlp_file, :resource => '<my_jnlp></my_jnlp>') }
    end

    context 'when the API responds with an unknown Content-Type' do
      before do
        @req_stub.to_return(:headers => { 'Content-Type' => 'other;application/xml;other' })
      end

      it 'is expected to raise a Unkown header error' do
        expect { @client.remote_control(uuid) }.to raise_error(RuntimeError, 'Unexpected Content-Type header')
      end
    end

    context 'when the server responds with an error status' do
      before do
        @req_stub.to_return(:status => [500, "Internal Server Error"])
      end

      it 'is expected to raise a Request failed error' do
        expect { @client.remote_control(uuid) }.to raise_error(RuntimeError, 'Request failed')
      end
    end

    context 'when an empty uuid is provided' do
      let(:uuid) { '' }

      it 'is expected to raise an error' do
        expect { @client.remote_control(uuid) }.to raise_error(RuntimeError, 'UUID must not be blank')
      end
    end

    context 'when a nil uuid is provided' do
      let(:uuid) { nil }

      it 'is expected to raise an error' do
        expect { @client.remote_control(uuid) }.to raise_error(RuntimeError, 'UUID must not be blank')
      end
    end
  end
end
