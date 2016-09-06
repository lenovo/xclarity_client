module XClarityClient
  class NodeBuilder < XClarityBase

    BASE_URI = '/nodes'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      nodes = []
      response = connection(BASE_URI)
      response.body[:nodeList].each do |node|
        nodes.push(Node.new(node))
      end
      nodes
    end

    def get_object_nodes(uuids)
     response = connection( BASE_URI + "/" + uuids.join(",") )
     build_node(response.body)
    end

  end
end
