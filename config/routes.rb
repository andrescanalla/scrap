Rails.application.routes.draw do
  root :to => "productos#buscar" 

  get 'archivos/listar_archivos'
  post 'archivos/listar_archivos'  
  post 'archivos/listar_archivos/brow' => 'archivos#abrir_brow', as: :brow
  post 'archivos/listar_archivos/down' => 'archivos#bajar_arch', as: :down
  post 'archivos/listar_archivos/check' => 'archivos#check', as: :check
  post 'archivos/listar_archivos/subir' => 'archivos#subir', as: :subir
  post 'archivos/listar_archivos/cerrar' => 'archivos#cerrar', as: :cerrar
  post 'archivos/listar_archivos/deletetemp' => 'archivos#deletetemp', as: :deletetemp
  get 'archivos/listar_archivos/delete' => 'archivos#delete', as: :delete


   get 'subirproducto/subir_producto'
  post 'subirproducto/subir_producto'  
  post 'subirproducto/subir_producto/brow' => 'subirproducto#abrir_brow', as: :browp

  get 'subirproducto/subir_producto/down' => 'subirproducto#bajar_arch', as: :downp
  get 'subirproducto/subir_producto/check' => 'subirproducto#check', as: :checkp
  get 'subirproducto/subir_producto/subir' => 'subirproducto#subir', as: :subirp
  get 'subirproducto/subir_producto/cerrar' => 'subirproducto#cerrar', as: :cerrarp
  post 'subirproducto/subir_producto/deletetemp' => 'subirproducto#deletetemp', as: :deletetempp
  get 'subirproducto/subir_producto/delete' => 'subirproducto#delete', as: :deletep
  get 'subirproducto/subir_producto/edit' => 'subirproducto#edit', as: :edit
  

  
  resources :stocks
  resources :tipos
  resources :pedidos
  resources :detalleordens
  resources :ordens
  resources :productos
  get '/importar/producto' => 'productos#importar'
  post '/importar/producto' => 'productos#importar'
  get '/buscar/producto' => 'productos#buscar'
  post '/buscar/producto' => 'productos#buscar'
  get '/buscar2/producto' => 'productos#buscar2'
  post '/buscar2/producto' => 'productos#buscar2'
  
  get '/buscar/producto' => 'productos#remplazar_todo'
  get '/buscar/producto' => 'productos#remplazar_stock'
  post '/comparar/producto' => 'productos#comparar'
  get '/comparar/producto' => 'productos#comparar'
  #get '/comparar/brow' => 'productos#abrir_brow', as: :brow
  post '/comparar_hym/producto' => 'productos#comparar_hym'
  get '/comparar_hym/producto' => 'productos#comparar_hym'
  get '/importar/resultado_imp' => 'productos#resultado_imp'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
