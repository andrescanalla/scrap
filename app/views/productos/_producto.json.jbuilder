json.extract! producto, :id, :codebar, :producto, :talle, :style, :imagen, :created_at, :updated_at
json.url producto_url(producto, format: :json)