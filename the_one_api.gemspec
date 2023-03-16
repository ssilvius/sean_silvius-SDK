# frozen_string_literal: true

require_relative "lib/the_one_api/version"

Gem::Specification.new do |spec|
  spec.name = "the_one_api"
  spec.version = TheOneApi::VERSION
  spec.authors = ["Sean Silvius"]
  spec.email = ["sean@sivius.me"]

  spec.summary = "SDK to consume the /movies endpoint of the one api"
  spec.description = "SDK to consume the /movies endpoint of the one api"
  spec.homepage = "https://github.com/ssilvius/ssilvius-sdk"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/ssilvius/ssilvius-sdk/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "json"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "yard-tomdoc"
end
