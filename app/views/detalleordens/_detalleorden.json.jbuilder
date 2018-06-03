json.extract! detalleorden, :id, :id_orden, :id_producto, :cant, :precio, :id_tipo, :chequeado, :created_at, :updated_at
json.url detalleorden_url(detalleorden, format: :json)