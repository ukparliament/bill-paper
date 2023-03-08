require 'import/import'

# We include code from module.
include IMPORT

task :import_bills => :environment do
  import_bills( 0 )
end