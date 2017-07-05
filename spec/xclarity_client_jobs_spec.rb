require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
  end

  before :each do
    @includeAttributes = %w(isCancelable status)
    @excludeAttributes = %w(isCancelable status)
    @uuidArray = @client.discover_jobs.map { |job| job.id  }
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /jobs' do

    it 'should respond with an array' do
      expect(@client.discover_jobs).not_to be_empty
    end

    context 'with option uuid' do
      it 'should return an array' do
        expect(@client.discover_jobs({"uuid":"FEE5C5988F23453F8367597C3561DC54"})).not_to be_empty
      end
    end
    
    context 'with option state' do
      it 'should return an array' do
        expect(@client.discover_jobs({"state":"Stopped_With_Error"})).not_to be_empty
      end
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_jobs(nil,@includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |job|
          @includeAttributes.map do |attribute|
            expect(job.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_jobs(nil,nil,@excludeAttributes)
        expect(response).not_to be_empty
        response.map do |job|
          @excludeAttributes.map do |attribute|
            expect(job.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'GET /jobs/UUID' do
    context 'without include or exclude' do
      it 'include attributes should not be nil' do
        response = @client.fetch_jobs([@uuidArray[0]], nil,nil)
        expect(response).not_to be_empty
        response.map do |job|
          @includeAttributes.map do |attribute|
            expect(job.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with includeAttributes' do
      it 'include attributes should not be nil' do
        response = @client.fetch_jobs([@uuidArray[0]], @includeAttributes,nil)
        expect(response).not_to be_empty
        response.map do |job|
          @includeAttributes.map do |attribute|
            expect(job.send(attribute)).not_to be_nil
          end
        end
      end
    end

    context 'with excludeAttributes' do
      it 'exclude attributes should be nil' do
        response = @client.fetch_jobs([@uuidArray[0]], nil, @excludeAttributes)
        expect(response).not_to be_empty
        response.map do |job|
          @excludeAttributes.map do |attribute|
            expect(job.send(attribute)).to be_nil
          end
        end
      end
    end
  end

  describe 'PUT /jobs/UUID' do
    context 'cancel the job' do
      it 'cancels the job' do
        @client.cancel_job(@uuidArray[0])
        uri = "#{@host}/jobs/#{@uuidArray[0]}"
        request_body = { 'body' => {'cancelRequest' => 'true'} }
        expect(a_request(:put, uri).with(request_body)).to have_been_made
      end
    end
  end

  describe 'DELETE /jobs/UUID' do
    context 'delete the job' do
      it 'deletes the job' do
        @client.delete_job(@uuidArray[0])
        uri = "#{@host}/jobs/#{@uuidArray[0]}"
        expect(a_request(:delete, uri)).to have_been_made
      end
    end
  end

end
