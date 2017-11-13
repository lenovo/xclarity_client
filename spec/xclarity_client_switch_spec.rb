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

  before :each do
    @includeAttributes = %w(accessState attachedNodes)
    @excludeAttributes = %w(accessState attachedNodes)
    @uuidArray = @client.discover_switches.map { |switch| switch.uuid  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /switches' do
    it 'should respond with an array' do
      expect(@client.discover_switches.class).to eq(Array)
    end

    context "with includeAttributes" do
      before :each do
        @response = @client.fetch_switches(nil,@includeAttributes,nil)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @includeAttributes.map do |attribute|
            expect(switch.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context "with excludeAttributes" do
      before :each do
        @response = @client.fetch_switches(nil,nil,@excludeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @excludeAttributes.map do |attribute|
            expect(switch.send(attribute)).to satisfy("atribute must be nil or empty") do |v|
              v == nil || v.empty?
            end
          end
        end
      end
    end
  end

  describe 'GET /switches/UUID,UUID,...,UUID' do

    context "with includeAttributes" do
      before :each do
        @response = @client.fetch_switches(@uuidArray, @includeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @includeAttributes.map do |attribute|
            expect(switch.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context "with excludeAttributes" do
      before :each do
        @response = @client.fetch_switches(@uuidArray, nil, @excludeAttributes)
      end

      it 'missing attributes should be nil' do
        @response.map do |switch|
          @excludeAttributes.map do |attribute|
            expect(switch.send(attribute)).to satisfy("atribute must be nil or empty") do |v|
              v == nil || v.empty?
            end
          end
        end
      end
    end
  end

  describe 'GET /switches/UUID' do
    context 'attributes included in the version 1.4' do
      it 'getting new attributes' do
        uuid = "F5710BE70F223D8C91D74D9161159617"
        response = @client.fetch_switches([uuid])
        response.each do |switch|
          switch.ntpPushEnabled.should_not be_nil
          switch.ntpPushFrequency.should_not be_nil
          switch.location.should_not be_nil
          switch.height.should_not be_nil
          switch.memoryUtilization.should_not be_nil
          switch.mgmtProcIPaddress.should_not be_nil
          switch.temperatureSensors.should_not be_nil
          switch.entitleSerialNumber.should_not be_nil
          switch.manufacturingDate.should_not be_nil
          switch.panicDump.should_not be_nil
          switch.powerSupply.should_not be_nil
          switch.stackRole.should_not be_nil
          switch.fans.should_not be_nil
          switch.contact.should_not be_nil
          switch.sysObjectID.should_not be_nil
          switch.savePending.should_not be_nil
          switch.resetReason.should_not be_nil
          switch.applyPending.should_not be_nil
          switch.OS.should_not be_nil
          switch.cpuUtilization.should_not be_nil
          switch.ports.should_not be_nil
          switch.upTime.should_not be_nil
        end
      end
    end
  end
end
