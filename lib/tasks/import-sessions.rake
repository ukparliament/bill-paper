require 'import'

# We include code from module.
include Import

task :import_sessions => :environment do
  import_sessions
end