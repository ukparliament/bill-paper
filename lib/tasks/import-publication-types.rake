require 'import/import'

# We include code from module.
include IMPORT

task :import_publication_types => :environment do
  import_publication_types( 0 )
end