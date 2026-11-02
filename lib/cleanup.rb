require 'open-uri'

# # A module for importing for the bill system API.
module Cleanup
  
  # ## A method to clean up deleted bills from the current session.
  def cleanup_deleted_bills_in_current_session
    puts "cleaning up deleted bills in the current session"
    
    # We get the current session.
    current_session = Session
      .order( 'parliament_number desc')
      .order( 'session_number desc')
      .first
      
    # We get all bills from the current session.
    bills = current_session.bills
    
    # For each bill in the current session ...
    bills.each do |bill|
    
      # ... we get the URI of the bill.
      uri = URI( "https://bills-api.parliament.uk/api/v1/Bills/#{bill.bill_system_id}" )
      
      # We get the connection to the URI.
      connection = Net::HTTP.start( uri.host, uri.port, use_ssl: true )
      
      # We get the response from the URI.
      response = connection.head( uri.path )
      
      # If the response code is 200 ...
      if response.code == '200'
      
        # ... we do nothing.
        
      # Otherwise, if the response code is not 200 ...
      else
      
        puts "Deleting bill #{bill.bill_system_id} with its publications and links"
        
        # ... we get all the publications for the bill.
        publications = bill.publications
        
        # For each publication ...
        publications.each do |publication|
        
          # ... we get all the links for the publication.
          links = publications.links
        
          # For each link ...
          links.each do |link|
          
            # ... we destroy the link.
            link.destroy!
          end
          
          # We destroy the publication.
          publication.destroy!
        end
        
        # We destroy the bill.
        bill.destroy!
      end
    end
  end
end