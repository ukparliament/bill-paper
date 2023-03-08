task :setup => [
  :import_bill_types,
  :import_publication_types,
  :import_bills,
  :import_all_publications ] do
end