require 'import/import'

# We include code from module.
include IMPORT

task :import_bill_types => :environment do
  import_bill_types
end