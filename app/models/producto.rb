class Producto < ApplicationRecord
  def self.table_name() "producto" end
  has_many :detalleordens
  has_many :ordens, through: :detalleordens

  #validates :codebar,
            #uniqueness: true #or validates_uniqueness_of :name

end
