describe XClarityClient do

  before :all do
    WebMock.allow_net_connect!
    conf = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://127.0.0.1:3000'
    )

    conf_blueprint = XClarityClient::Configuration.new(
    :username => 'admin',
    :password => 'pass',
    :host     => 'http://example.com'
    )

    @virtual_appliance = XClarityClient::VirtualApplianceManagement.new(conf_blueprint)
    @client = XClarityClient::Client.new(conf)
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /aicc' do
    it 'should respond with information about the Lenovo XClarity Administrator' do

      response = @virtual_appliance.configuration_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/ipdisable' do
    it 'should respond with the IPv6 and IPv6 addresses enablement state.' do

      response = @virtual_appliance.ip_enablement_state

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/host' do
    it 'should respond with the XClarity Administrator host settings.' do

      response = @virtual_appliance.host_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/interfaces/{interface}' do
    it 'should respond with information about a specific network interface.' do

      response = @virtual_appliance.network_interface_settings("eth0")

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/routes' do
    it 'should respond with all XClarity Administrator routes.' do

      response = @virtual_appliance.route_settings

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /aicc/network/host' do
    it 'should respond with all XClarity Administrator subscriptions.' do

      response = @virtual_appliance.subscriptions

      expect(response.status).to eq(200)
    end
  end

  describe 'GET /cmms' do
    it 'should respond with an array' do
      expect(@client.discover_cmms.class).to eq(Array)
    end

    it 'the response must have one or more nodes' do
      expect(@client.discover_cmms).not_to be_empty
    end

    describe 'GET /cmms/UUID with includeAttributes and excludeAttributes' do
      before :each do
        @includeAttributes = %w(accessState backedBy)
        @excludeAttributes = %w(accessState backedBy)
        @uuidArray = @client.discover_cmms.map { |cmm| cmm.uuid  }


      end

      it 'GET /cmms/UUID with includeAttributes' do

        @uuidArray.each do | cmm |

          response = @client.fetch_cmms(cmm, @includeAttributes)
          response.map do |cmm_response |
            @includeAttributes.map do |attribute|
              expect(cmm_response.send(attribute)).to be_nil
            end
          end
        end
      end

      it 'GET /cmms/UUID with excludeAttributes' do

        @uuidArray.each do | cmm |
          response = @client.fetch_cmms(cmm, nil, @excludeAttributes)
          response.map do |cmm_response|
            @excludeAttributes.map do |attribute|
              expect(cmm_response.send(attribute)).to be_nil
            end
          end
        end
      end

      it 'GET /cmms just with includeAttributes' do
        response = @client.fetch_cmms(nil,@includeAttributes,nil)
        response.map do |cmm|
          @includeAttributes.map do |attribute|
            expect(cmm.send(attribute)).to be_nil
          end
        end
      end
      it 'GET /cmms just with excludeAttributes' do
        response = @client.fetch_cmms(nil,nil,@excludeAttributes)
        response.map do |cmm|
          @excludeAttributes.map do |attribute|
            expect(cmm.send(attribute)).to be_nil
          end
        end
      end
    end

    describe 'GET /cmms/UUID,UUID,...,UUID' do

      it 'to multiples uuid, should return two or more cmms' do
        uuidArray = @client.discover_cmms.map { |cmms| cmms.uuid  }
        expect(uuidArray.length).to be >= 2
      end
    end
  end
end
