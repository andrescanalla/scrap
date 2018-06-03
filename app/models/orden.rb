class Orden < ApplicationRecord
  def self.table_name() "orden" end
  has_many :detalleordens
  has_many :productos, through: :detalleordens
end
