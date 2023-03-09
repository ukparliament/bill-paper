xml.item do
	xml.guid( link.url )
	xml.title( link.title )
	xml.link( link.url )
	xml.pubDate( link.publication_display_date.rfc822 )
	xml.description( link.description )
end