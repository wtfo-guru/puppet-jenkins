require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'

PuppetSyntax.hieradata_paths = [ "data/*.yaml", "data/**/*.yaml", "hiera*.yaml"]
PuppetSyntax.check_hiera_keys = true

PuppetLint::RakeTask.new :lint do |config|

  # Should puppet-lint prefix it's output with the file being checked,
  # defaults to true
  config.with_filename = false

  # List of checks to disable
  config.disable_checks = ['documentation', '80chars']

  # Should the task fail if there were any warnings, defaults to false
  config.fail_on_warnings = true

  # Format string for puppet-lint's output (see the puppet-lint help output
  # for details
  config.log_format = '%{filename} - %{message}'

  # Print out the context for the problem, defaults to false
  config.with_context = true

  # Enable automatic fixing of problems, defaults to false
  config.fix = false

  # Show ignored problems in the output, defaults to false
  config.show_ignored = true
end

task :integration => [:syntax, :lint, :metadata_lint, :spec]
