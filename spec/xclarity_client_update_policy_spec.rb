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
    :verify_ssl => ENV['LXCA_VERIFY_SSL'],
    :user_agent_label => ENV['LXCA_USER_AGENT_LABEL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
    @policy_name = "DEFAULT-11"
    @uuid = "A3F8482B012B32188E68375DD5FF40EE"
    @user_agent = ENV['LXCA_USER_AGENT_LABEL']
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /compliancePolicies' do
    it 'should respond with an array' do
      expect(@client.discover_update_policy).not_to be_empty
    end
  end

  describe 'GET /compliancePolicies/applicableFirmware' do
    it 'should respond with an array' do
      expect(@client.discover_application_firmware).not_to be_empty
    end
  end

  describe 'GET /compliancePolicies/compareResult' do
    it 'should respond with an array' do
      expect(@client.discover_compare_results).not_to be_empty
    end
  end

  describe 'GET /compliancePolicies/persistedResult' do
    it 'should respond with an array' do
      expect(@client.discover_persisted_compare_results).not_to be_empty
    end
  end

  describe 'POST /compliancePolicies/compareResult' do
    context 'assigns the compliance policy with all default values(autoAssign=false, keep=true)' do
      it 'assigns the compliance policy' do
        @client.assign_compliance_policy(@policy_name,"IOSwitch", @uuid)
        uri = "#{@host}/compliancePolicies/compareResult"
        assign_hash = {:policyname => @policy_name, :type => "IOSwitch", :uuid => @uuid}
        assign_hash_str = assign_hash.to_json
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:post, uri).with(:body => "{\"compliance\": [#{assign_hash_str}]}", :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'assigns the compliance policy with autoAssign=true and default value for keep' do
      it 'assigns the compliance policy' do
        @client.assign_compliance_policy(@policy_name,"IOSwitch", @uuid, nil, "true")
        uri = "#{@host}/compliancePolicies/compareResult"
        assign_hash = {:policyname => @policy_name, :type => "IOSwitch", :uuid => @uuid, :autoAssign => true}
        assign_hash_str = assign_hash.to_json
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:post, uri).with(:body => "{\"compliance\": [#{assign_hash_str}]}", :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'assigns the compliance policy with keep=false and default value for autoAssign' do
      it 'assigns the compliance policy' do
        @client.assign_compliance_policy(@policy_name,"IOSwitch", @uuid, "false")
        uri = "#{@host}/compliancePolicies/compareResult"
        assign_hash = {:policyname => @policy_name, :type => "IOSwitch", :uuid => @uuid, :keep => false}
        assign_hash_str = assign_hash.to_json
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:post, uri).with(:body => "{\"compliance\": [#{assign_hash_str}]}", :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

  describe 'DELETE /compliancePolicies' do
    context 'deletes the compliance policies with removePackage set to true' do
      it 'deletes the policy' do
        @client.delete_compliance_policy(@policy_name,"true")
        uri = "#{@host}/compliancePolicies?policyName=#{@policy_name}&removePackage=true"
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:delete, uri).with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'deletes the compliance policies with removePackage set to false' do
      it 'deletes the policy' do
        @client.delete_compliance_policy(@policy_name,"false")
        uri = "#{@host}/compliancePolicies?policyName=#{@policy_name}&removePackage=false"
        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:delete, uri).with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end

end
