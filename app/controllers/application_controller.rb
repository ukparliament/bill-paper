class ApplicationController < ActionController::Base
  include LibraryDesign::Crumbs

  $SITE_TITLE = 'Bill papers'
end
