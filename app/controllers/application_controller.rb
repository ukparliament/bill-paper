class ApplicationController < ActionController::Base
  include LibraryDesign::Crumbs

  $SITE_TITLE = 'Bill Papers'
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )

  private
  
  def csv_title_from_page_title( page_title )
    page_title.downcase.gsub( ' ', '-' ).gsub( '---', '-' )
  end
end
