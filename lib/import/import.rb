# # A module for importing for the bill system API.
module IMPORT
  
  # ## A method to import sessions.
  def import_sessions
    puts "importing sessions"
    
    # We set the URL to import from.
    url = "https://whatson-api.parliament.uk/calendar/sessions/list.json"
    
    # We get the JSON.
    json = JSON.load( URI.open( url ) )
    
    # For each session item in the feed ...
    json.each do |session_item|
      
      # ... we store the returned values.
      session_item_bill_system_id = session_item['SessionId']
      session_item_number = session_item['Number']
      session_item_start_on = session_item['StartDate']
      session_item_end_on = session_item['EndDate']
      session_item_commons_description = session_item['CommonsDescription']
      session_item_lords_description = session_item['LordsDescription']
      session_item_parliament_number = session_item['ParliamentNumber']
      session_item_session_number = session_item['SessionNumber']
      
      # We attempt to find the session.
      session = Session.find_by_bill_system_id( session_item_bill_system_id )
      
      # If we don't find the session ...
      unless session
        
        # ... we create a new session.
        session = Session.new
        session.bill_system_id = session_item_bill_system_id
      end
    
      # We update the current attributes for the session.
      session.number = session_item_number
      session.start_on = session_item_start_on
      session.end_on = session_item_end_on
      session.commons_description = session_item_commons_description
      session.lords_description = session_item_lords_description
      session.parliament_number = session_item_parliament_number
      session.session_number = session_item_session_number
      
      session.save!
    end
  end

  # ## A method to import bill types.
  def import_bill_types
    puts "importing bill types"
    
    # We set the URL to import from.
    url = "https://bills-api.parliament.uk/api/v1/BillTypes"
    
    # We get the JSON.
    json = JSON.load( URI.open( url ) )
    
    # For each bill type item in the feed ...
    json['items'].each do |bill_type_item|
      
      # ... we store the returned values.
      bill_type_item_bill_system_id = bill_type_item['id']
      bill_type_item_category = bill_type_item['category']
      bill_type_item_name = bill_type_item['name']
      bill_type_item_description = bill_type_item['description']
      
      # We attempt to find the bill catgory.
      bill_category = BillCategory.find_by_label( bill_type_item_category )
      
      # If we don't find the bill category ...
      unless bill_category
        bill_category = BillCategory.new
        bill_category.label = bill_type_item_category
        bill_category.save
      end
      
      # We attempt to find the bill type.
      bill_type = BillType.find_by_bill_system_id( bill_type_item_bill_system_id )
      
      # If we don't find the bill type ...
      unless bill_type
        
        # ... we create a new bill type.
        bill_type = BillType.new
        bill_type.bill_system_id = bill_type_item_bill_system_id
        bill_type.label = bill_type_item_name
        bill_type.description = bill_type_item_description
        bill_type.bill_category = bill_category
        bill_type.save
      end
    end
  end
  
  # ## A method to import publication types including a parameter for the number of records to skip.
  def import_publication_types( skip )
    puts "importing publication types"
    
    # We set the URL to import from.
    url = "https://bills-api.parliament.uk/api/v1/PublicationTypes?take=20&skip=#{skip}"
    
    # We get the JSON.
    json = JSON.load( URI.open( url ) )
    
    # For each bill item in the feed ....
    json['items'].each do |publication_type_item|
      
      # ... we store the returned values.
      publication_type_item_bill_system_id = publication_type_item['id']
      publication_type_item_label = publication_type_item['name']
      publication_type_item_description = publication_type_item['description']
      
      # We attempt to find the publication type
      publication_type = PublicationType.find_by_bill_system_id( publication_type_item_bill_system_id )
      
      # If we don't find the publication type ...
      unless publication_type
        
        # ... we create a new publication type.
        publication_type = PublicationType.new
        publication_type.label = publication_type_item_label
        publication_type.bill_system_id = publication_type_item_bill_system_id
        publication_type.description = publication_type_item_description
        publication_type.save
      end
    end
    
    # We get the total results count from the API.
    total_results = json['totalResults']
    
    # If the total results count is greater than the number of results skipped ...
    if total_results > skip
      
      # ... we call this method again, incrementing the skip by by 20 results.
      import_publication_types( skip + 20 )
    end
  end
  
  # ## A method to import bills including a parameter for the number of records to skip.
  def import_all_bills( skip )
    puts "importing bills"
    
    # We set the URL to import from.
    url = "https://bills-api.parliament.uk/api/v1/Bills?take=20&skip=#{skip}"
    
    # We get the JSON.
    json = JSON.load( URI.open( url ) )
    
    # For each bill item in the feed ....
    json['items'].each do |bill_item|
      
      # ... we import the bill if we've not seen it before.
      import_bill( bill_item )
    end
    
    # We get the total results count from the API.
    total_results = json['totalResults']
    
    # If the total results count is greater than the number of results skipped ...
    if total_results > skip
      
      # ... we call this method again, incrementing the skip by by 20 results.
      import_all_bills( skip + 20 )
    end
  end
  
  # ## A method to import bills from the current session including a parameter for the number of records to skip.
  def import_bills_from_current_session( skip )
    puts "importing bills from current session"
    
    # We get the current session.
    current_session = Session
      .order( 'parliament_number desc')
      .order( 'session_number desc')
      .first
      
    # We set the URL to import from.
    # This returns bills from the current session that haven't been defeated or withdrawn.
    url = "https://bills-api.parliament.uk/api/V1/Bills?session=#{current_session.bill_system_id}&isDefeated=false&isWithdrawn=false&take=20&skip=#{skip}"
      
    # We get bills from the current session.
    json = JSON.load( URI.open( url ) )
    
    # For each bill item in the feed ....
    json['items'].each do |bill_item|
      
      # ... we import the bill if we've not seen it before.
      import_bill( bill_item )
    end
    
    # We get the total results count from the API.
    total_results = json['totalResults']
    
    # If the total results count is greater than the number of results skipped ...
    if total_results > skip
      
      # ... we call this method again, incrementing the skip by by 20 results.
      import_bills_from_current_session( skip + 20 )
    end
  end
  
  # ## A method to import publications.
  def import_all_publications
    puts "importing all publications"
    
    # We get all the bills.
    bills = Bill.all
    
    # For each bill ...
    bills.each do |bill|
      
      # ... we import its publications.
      import_publications_for_bill( bill )
    end
  end
  
  # ## A method to import publications from bills in the current session.
  def import_publications_from_bills_in_current_session
    puts "importing publications from bills in the current session"
    
    # We get the current session.
    current_session = Session
      .order( 'parliament_number desc')
      .order( 'session_number desc')
      .first
      
    # We get all bills from the current session.
    bills = current_session.bills
      
    # For each bill ...
    bills.each do |bill|
      
      # ... we import its publications.
      import_publications_for_bill( bill )
    end
  end
  
  # ## A method to import a bill we've not seen before.
  def import_bill( bill_item )
    
    # We store the returned values.
    bill_item_bill_system_id = bill_item['billId']
    bill_item_short_title = bill_item['shortTitle']
    bill_item_originating_house = bill_item['originatingHouse']
    bill_item_bill_type_id = bill_item['billTypeId']
    bill_item_originating_session_id = bill_item['introducedSessionId']
    bill_item_current_house = bill_item['currentHouse']
    bill_item_is_act = bill_item['isAct']
    bill_item_is_withdrawn = bill_item['billWithdrawn']
    bill_item_is_defeated = bill_item['isDefeated']
    bill_item_updated = bill_item['lastUpdate']
    
    # We attempt to find the originating session.
    session = Session.find_by_bill_system_id( bill_item_originating_session_id )
    
    # We attempt to find the originating House.
    originating_house = ParliamentaryHouse.find_by_short_label( bill_item_originating_house )
    
    # We attempt to find the current House.
    current_house = ParliamentaryHouse.find_by_short_label( bill_item_current_house ) unless bill_item_current_house == 'Unassigned'
    
    # We attempt to find the bill by its bill system ID.
    bill = Bill.find_by_bill_system_id( bill_item_bill_system_id )
    
    # We attempt to find the bill type.
    bill_type = BillType.find_by_bill_system_id( bill_item_bill_type_id )
    
    # If we don't find the bill ...
    unless bill
      
      # ... we create a new bill.
      puts "importing bill: #{bill_item_short_title} with ID #{bill_item_bill_system_id}"
      bill = Bill.new
      bill.bill_system_id = bill_item_bill_system_id
      bill.short_title = bill_item_short_title
      bill.originating_house_id = originating_house.id if originating_house
      bill.bill_type = bill_type
      bill.originating_session_id = session.id
    end
    
    # We update the current attributes for the bill.
    bill.current_house_id = current_house.id if current_house
    bill.is_act = bill_item_is_act
    bill.is_withdrawn = bill_item_is_withdrawn if bill_item_is_withdrawn
    bill.is_defeated = bill_item_is_defeated
    bill.updated = bill_item_updated
    bill.save
  end
  
  # ## A method to import publications for a given bill.
  def import_publications_for_bill( bill )
    
    # We set the URL to import from.
    url = "https://bills-api.parliament.uk/api/v1/Bills/#{bill.bill_system_id}/Publications"
  
    # We get the JSON.
    json = JSON.load( URI.open( url ) )
    
    # For each publication item in the feed ...
    json['publications'].each do |publication_item|
      
      # ... we store the returned values.
      publication_item_house_label = publication_item['house']
      publication_item_bill_system_id = publication_item['id']
      publication_item_title = publication_item['title']
      publication_item_publication_type_id = publication_item['publicationType']['id']
      publication_item_display_date = publication_item['displayDate']
      
      # We find the publication type.
      publication_type = PublicationType.find_by_bill_system_id( publication_item_publication_type_id )
      
      # We find the House.
      house = ParliamentaryHouse.find_by_short_label( publication_item_house_label )
      
      # We attempt to find the publication.
      publication = Publication.find_by_bill_system_id( publication_item_bill_system_id )
      
      # If we don't find the publication ...
      unless publication
        
        # ... we create a new publication.
        publication = Publication.new
        publication.title = publication_item_title
        publication.display_date = publication_item_display_date
        publication.bill_system_id = publication_item_bill_system_id
        publication.parliamentary_house = house if publication_item_house_label
        publication.publication_type = publication_type
        publication.bill = bill
        publication.save
        
        # We log the import.
        puts "importing publication: #{publication_item_title}"
        
        # For each link attached to a publication ...
        publication_item['links'].each do |link_item|
        
          # ... we store the returned values.
          link_item_bill_system_id = link_item['id']
          link_item_title = link_item['title']
          link_item_url = link_item['url']
          link_item_content_type = link_item['contentType']
          
          # We attempt to find the content type.
          content_type = ContentType.find_by_content_type( link_item_content_type )
          
          # If we don't find the content type ...
          unless content_type
            
            # ... we create a new content type.
            content_type = ContentType.new
            content_type.content_type = link_item_content_type
            content_type.save
          end
        
          # We create a new link.
          link = Link.new
          link.bill_system_id = link_item_bill_system_id
          link.title = link_item_title
          link.url = link_item_url
          link.content_type = content_type
          link.source = 'link'
          link.publication = publication
          link.save
        end
        
        # For each file attached to a publication ...
        publication_item['files'].each do |publication_file_item|
          
          # ... we store the returned values.
          publication_file_item_bill_system_id = publication_file_item['id']
          publication_file_item_filename = publication_file_item['filename']
          publication_file_item_content_length = publication_file_item['contentLength']
          publication_file_item_content_type = publication_file_item['contentType']
          
          # We attempt to find the content type.
          content_type = ContentType.find_by_content_type( publication_file_item_content_type )
          
          # If we don't find the content type ...
          unless content_type
            
            # ... we create a new content type.
            content_type = ContentType.new
            content_type.content_type = publication_file_item_content_type
            content_type.save
          end
        
          # We create a new publication file.
          link = Link.new
          link.bill_system_id = publication_file_item_bill_system_id
          link.title = publication_file_item_filename
          link.url = "https://bills.parliament.uk/publications/#{publication_item_bill_system_id}/documents/#{publication_file_item_bill_system_id}"
          link.content_length = publication_file_item_content_length
          link.content_type = content_type
          link.source = 'file'
          link.publication = publication
          link.save
        end
      end
    end
  end
end