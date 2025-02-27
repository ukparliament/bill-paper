require 'import'

# We include code from module.
include Import

task :import_all_bills => :environment do
  import_all_bills( 0 )
end