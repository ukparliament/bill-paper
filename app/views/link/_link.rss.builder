xml.item do
	xml.guid( link.url )
	xml.title( link.title )
	xml.link( link.url )
	xml.link( link.publication.display_date.rfc822 )
	xml.description( link.description )
end