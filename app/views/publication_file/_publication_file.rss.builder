xml.item do
	xml.guid( publication_file.url )
	xml.title( publication_file.filename )
	xml.link( publication_file.url )
	xml.link( publication_file.publication.display_date.rfc822 )
	xml.description( publication_file.description )
end