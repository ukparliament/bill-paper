require 'import'

# We include code from module.
include Import

task :import_bills_from_current_session => :environment do
  import_bills_from_current_session( 0 )
end