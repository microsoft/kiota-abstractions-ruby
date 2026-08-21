# frozen_string_literal: true

require_relative 'lib/microsoft_kiota_serialization_json/version'

Gem::Specification.new do |spec|
  spec.name          = 'microsoft_kiota_serialization_json'
  spec.version       = MicrosoftKiotaSerializationJson::VERSION
  spec.authors       = 'Microsoft Corporation'
  spec.email         = 'graphsdkpub+ruby@microsoft.com'
  spec.description   = 'Implementation of Kiota Serialization interfaces for JSON'
  spec.summary       = 'Microsoft Kiota Serialization - Ruby serialization for building library agnostic http client'
  spec.homepage      = 'https://microsoft.github.io/kiota/'
  spec.license       = 'MIT'
  spec.metadata      = {
    'bug_tracker_uri' => 'https://github.com/microsoft/kiota-ruby/issues',
    'changelog_uri' => 'https://github.com/microsoft/kiota-ruby/blob/main/CHANGELOG.md',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => 'https://github.com/microsoft/kiota-ruby/tree/main/components/serialization/json',
    'github_repo' => 'ssh://github.com/microsoft/kiota-ruby',
    'rubygems_mfa_required' => 'true'
  }
  spec.required_ruby_version = '>= 3.3.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'json', '>= 2.6.3', '< 2.22.0'
  spec.add_dependency 'microsoft_kiota_abstractions', '>= 0.17', '< 0.18'
  spec.add_dependency 'uuidtools', '>= 2.2', '< 3.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
