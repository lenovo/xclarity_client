# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xclarity_client/version'

Gem::Specification.new do |spec|
  spec.name          = "xclarity_client"
  spec.version       = XClarityClient::VERSION
  spec.authors       = ["Julian Cheal"]
  spec.email         = ["jcheal@redhat.com"]

  spec.summary       = %q{Lenovo XClairty API Client}
  spec.homepage      = "https://github.com/juliancheal/xclarity_client"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "apib-mock_server", "~> 1.0.3"
  spec.add_development_dependency "webmock", "~> 2.1.0"
  spec.add_dependency             "faraday", "~> 0.9.2"
end
