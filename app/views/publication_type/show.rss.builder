xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
		xml.title( @publication_type.label )
		xml.description( "Updates whenever a new paper is published." )
		xml.link( publication_type_show_url( :publication_type => @publication_type.bill_system_id ) )
		xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
		xml.language( 'en-uk' )
		xml.managingEditor( 'somervillea@parliament.uk (Anya Somerville)' )
		xml.pubDate( @publication_type.publications.first.display_date.rfc822 ) unless @publication_type.publications.empty?
		xml.tag!( 'atom:link', { :href => publication_type_show_url( :publication_type => @publication_type.bill_system_id, :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		xml << render( :partial => 'link/link', :collection => @publication_type.links ) unless @publication_type.links.empty?
	end
end