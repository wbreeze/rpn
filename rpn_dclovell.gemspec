
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rpn_dclovell/version"

Gem::Specification.new do |spec|
  spec.name          = "rpn_dclovell"
  spec.version       = RpnDclovell::VERSION
  spec.authors       = ["Douglas Lovell"]
  spec.email         = ["doug@wbreeze.com"]

  spec.summary = 'A command-line reverse polish notation (RPN) ' \
     'calculator written in Ruby'
  spec.description = 'Provides a command that accepts input for a basic '\
     'prefix notation expression evaluator.'
  spec.homepage = 'https://github.com/wbreeze/rpn'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
