Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  
  get 'bill-papers/bills' => 'bill#index', :as => 'bill_list'
  get 'bill-papers/bills/:bill' => 'bill#show', :as => 'bill_show'
  
  get 'bill-papers/bill-types' => 'bill_type#index', :as => 'bill_type_list'
  get 'bill-papers/bill-types/:bill_type' => 'bill_type#show', :as => 'bill_type_show'
  
  get 'bill-papers/bill-categories' => 'bill_category#index', :as => 'bill_category_list'
  get 'bill-papers/bill-categories/:bill_category' => 'bill_category#show', :as => 'bill_category_show'
  
  get 'bill-papers/publication-types' => 'publication_type#index', :as => 'publication_type_list'
  get 'bill-papers/publication-types/:publication_type' => 'publication_type#show', :as => 'publication_type_show'
end
