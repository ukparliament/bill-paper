class ApplicationController < ActionController::Base
  include LibraryDesign::Crumbs

  $SITE_TITLE = 'Bill Papers'
  
  $TOGGLE_PORTCULLIS = ENV.fetch( "TOGGLE_PORTCULLIS", 'off' )
end
