require 'import/import'

# We include code from module.
include IMPORT

task :import_sessions => :environment do
  import_sessions
end