
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "member_reminder/version"

Gem::Specification.new do |spec|
  spec.name          = "member_reminder"
  spec.version       = MemberReminder::VERSION
  spec.authors       = ["tripleCC"]
  spec.email         = ["triplec.linux@gmail.com"]

  spec.summary       = %q{钉钉提醒组员.}
  spec.description   = %q{钉钉提醒组员.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
