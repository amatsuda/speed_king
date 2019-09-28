require_relative 'lib/speed_king/version'

Gem::Specification.new do |spec|
  spec.name          = "speed_king"
  spec.version       = SpeedKing::VERSION
  spec.authors       = ["Akira Matsuda"]
  spec.email         = ["ronnie@dio.jp"]

  spec.summary       = 'A curation of aggressive monkey-patches for Rails'
  spec.description   = 'Rails performance booster'
  spec.homepage      = 'https://github.com/amatsuda/speed_king'
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["source_code_uri"] = spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
