require 'spec_helper'

describe XClarityClient do
  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.
  end

  let(:conf) do
    XClarityClient::Configuration.new(
      username:   ENV['LXCA_USERNAME'],
      password:   ENV['LXCA_PASSWORD'],
      host:       ENV['LXCA_HOST'],
      port:       ENV['LXCA_PORT'],
      auth_type:  ENV['LXCA_AUTH_TYPE'],
      verify_ssl: ENV['LXCA_VERIFY_SSL']
    )
  end

  let(:client) { XClarityClient::Client.new conf }

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  context 'with discover_storages' do
    before do
      @storages = client.discover_storages
    end

    it 'should respond with an array' do
      expect(@storages.class).to eq(Array)
      expect(@storages.any?).to eq(true)
    end

    it 'correct response values' do
      storage = @storages[0]
      expect(storage.name).to eq('S3200-1')
      expect(storage.type).to eq('Lenovo Storage')
      expect(storage.accessState).to eq('Online')
      expect(storage.driveBays).to eq(12)
      expect(storage.enclosureCount).to eq(1)
      expect(storage.canisterSlots).to eq(2)
    end
  end

  context 'with fetch_storages' do
    before do
      @include_attributes = %w[name type accessState driveBays enclosureCount canisterSlots room]
      @exclude_attributes = %w[type room]
      @uuids = client.discover_storages.map { |storage| storage.uuid }
    end

    it 'empty attribute should not be nil' do
      storage = client.fetch_storages(@uuids, @include_attributes).first
      expect(storage.room).to eq('')
    end

    it 'missing attribute should be nil' do
      storage = client.fetch_storages(@uuids, @include_attributes).first
      expect(storage.location).to be_nil
    end

    it 'excluded attribute should be nil' do
      storage = client.fetch_storages(@uuids, nil, @exclude_attributes).first
      expect(storage.room).to be_nil
    end

    it 'included attributes must have values if not excluded' do
      storage = client.fetch_storages(@uuids, @include_attributes, @exclude_attributes).first
      expect(storage.name).to eq('S3200-1')
      expect(storage.accessState).to eq('Online')
      expect(storage.driveBays).to eq(12)
      expect(storage.enclosureCount).to eq(1)
      expect(storage.canisterSlots).to eq(2)
    end
  end
end
