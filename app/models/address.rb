class Address < ApplicationRecord
  STATES = %w[AC Al AP AM BA CE DF ES GO MA MT MS MG PA PB PE PI RJ RN RS RO RR SC SP SE TO]

  belongs_to :addressable, polymorphic: true

  validates :zipcode, presence: true,
                      length: { maximum: 255 },
                      numericality: { only_integer: true }
  validates :street, presence: true,
                     length: { maximum: 255 }
  validates :neighboorhood, presence: true,
                            length: { maximum: 255 }
  validates :city, presence: true,
                   length: { maximum: 255 }
  validates :state, presence: true,
                    inclusion: { in: STATES }
  validates :ibge_code, allow_blank: true,
                        numericality: true,
                        length: { maximum: 255 }
  validates :complement, allow_blank: true,
                         length: { maximum: 255 }

  before_validation :cleasing

  def cleasing
    self.zipcode = zipcode.to_s.gsub(/\D/, '')
    self.ibge_code = zipcode.to_s.gsub(/\D/, '')
  end
end
