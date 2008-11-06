Gem::Specification.new do |s|
  s.name = %q{isbn_validation}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Plante"]
  s.date = %q{2008-11-03}
  s.description = %q{isbn_validation adds an isbn validation routine to active record models.}
  s.email = %q{nap@zerosum.org}
  s.extra_rdoc_files = ["README"]
  s.files = ["MIT-LICENSE", "Rakefile", "README", "lib/isbn_validation.rb", "test/isbn_validation_test.rb", "test/models.rb", "test/schema.rb", "test/test_helper.rb", "rails/init.rb"]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{isbn_validation adds an isbn validation routine to active record models.}
  s.test_files = ["test/isbn_validation_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.1.2"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.1.2"])
  end
end
