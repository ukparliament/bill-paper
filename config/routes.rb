require 'library_design'

Rails.application.routes.draw do
  # To load library design partials
  mount LibraryDesign::Engine => "/library_design"

  root "home#index"
  
  get 'bill-papers' => 'home#index', :as => 'home'
  
  get 'bill-papers/sessions' => 'session#index', :as => 'session_list'
  get 'bill-papers/sessions/:session' => 'session#show', :as => 'session_show'
  
  get 'bill-papers/bills' => 'bill#index', :as => 'bill_list'
  get 'bill-papers/bills/:bill' => 'bill#show', :as => 'bill_show'
  
  get 'bill-papers/bill-types' => 'bill_type#index', :as => 'bill_type_list'
  get 'bill-papers/bill-types/:bill_type' => 'bill_type#show', :as => 'bill_type_show'
  
  get 'bill-papers/bill-categories' => 'bill_category#index', :as => 'bill_category_list'
  get 'bill-papers/bill-categories/:bill_category' => 'bill_category#show', :as => 'bill_category_show'
  
  get 'bill-papers/publication-types' => 'publication_type#index', :as => 'publication_type_list'
  get 'bill-papers/publication-types/:publication_type' => 'publication_type#show', :as => 'publication_type_show'
  
  get 'bill-papers/meta' => 'meta#index', :as => 'meta_list'
  get 'bill-papers/meta/schema' => 'meta#schema', :as => 'meta_schema'
  get 'bill-papers/meta/bookmarklet' => 'meta#bookmarklet', :as => 'meta_bookmarklet'
  get 'bill-papers/meta/cookies' => 'meta#cookies', :as => 'meta_cookies'
end
