require 'import'

# We include code from module.
include Import

task :import_publications_from_bills_in_current_session => :environment do
  import_publications_from_bills_in_current_session
end