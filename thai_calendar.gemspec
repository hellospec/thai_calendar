# frozen_string_literal: true

require_relative "lib/thai_calendar/version"

Gem::Specification.new do |spec|
  spec.name                  = "thai_calendar"
  spec.version               = ThaiCalendar::VERSION
  spec.authors               = ["woot"]
  spec.email                 = ["worrawutp@hellospec.com"]
  spec.license               = "MIT"

  spec.summary               = "Thai Calendar"
  spec.description           = "Thai Calendar"
  spec.homepage              = "https://github.com/hellospec/thai_calendar"
  spec.required_ruby_version = ">= 3.0"
  spec.files                 = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  spec.require_paths         = ["lib"]

  spec.metadata = {
    "homepage_uri"    => spec.homepage,
    "source_code_uri" => spec.homepage
  }

  spec.add_runtime_dependency "activesupport", "~> 7.0", ">= 7.0.3"
end

