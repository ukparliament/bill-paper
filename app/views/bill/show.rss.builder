xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
		xml.title( @bill.short_title )
		xml.description( "Updates whenever a new paper is published." )
		xml.link( bill_show_url( :bill => @bill.bill_system_id ) )
		xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
		xml.language( 'en-uk' )
		xml.managingEditor( 'somervillea@parliament.uk (Anya Somerville)' )
		xml.pubDate( @bill.publications.first.display_date.rfc822 ) unless @bill.publications.empty?
		xml.tag!( 'atom:link', { :href => bill_show_url( :bill => @bill.bill_system_id, :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		xml << render( :partial => 'link/link', :collection => @bill.links ) unless @bill.links.empty?
	end
end