require 'cleanup'

# We include code from module.
include Cleanup

task :cleanup => :environment do
  cleanup_deleted_bills_in_current_session
end