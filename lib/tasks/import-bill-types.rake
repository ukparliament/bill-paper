require 'import'

# We include code from module.
include Import

task :import_bill_types => :environment do
  import_bill_types
end