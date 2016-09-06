module XClarityClient
  class NodeController < XClarityBase

    BASE_URI = '/nodes'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)
      response.body[:nodeList].map do |node|
        Node.new node
      end
    end

    def get_object_nodes(uuids)
      response = connection(BASE_URI + "/" + uuids.join(","))
      response.body[:nodeList].map do |node|
        Node.new node
      end
    end

    def get_object_nodes_exclude_attributes(uuids, attributes)
      response = connection(BASE_URI + "/" + uuids.join(",") + "?excludeAttributes" + attributes.join(","))
      response.body[:nodeList].map do |node|
        Node.new node
      end
    end

    def get_object_nodes_include_attributes(uuids, attributes)
      response = connection(BASE_URI + "/" + uuids.join(",")  + "?excludeAttributes" + attributes.join(","))
      response.body[:nodeList].map do |node|
        Node.new node
      end
    end

  end
end
