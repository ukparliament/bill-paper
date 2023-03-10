task :setup => [
  :import_sessions,
  :import_bill_types,
  :import_publication_types,
  :import_all_bills,
  :import_all_publications ] do
end