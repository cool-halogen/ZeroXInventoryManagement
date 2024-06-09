Rails.application.routes.draw do
  post 'inventory/init_catalog'
  post 'inventory/process_order'
  post 'inventory/process_restock'
end
