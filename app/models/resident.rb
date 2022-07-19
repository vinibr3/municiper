class Resident < ApplicationRecord
  has_one_attached :photo

  enum status: { inactive: 0, active: 1 }

  has_many :addresses, as: :addressable, dependent: :destroy

  validates :full_name, presence: true, length: { maximum: 255 }
  validates :document, presence: true, cpf: true
  validates :health_card_document, presence: true,
                                   brazilian_health_card_number: true,
                                   uniqueness: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 255 }
  validates :birthdate, presence: true
  validates :phone, presence: true,
                    format: { with: BRAZILIAN_PHONE_REGEX }
  validates :photo, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                                            size_range: 1..(5.megabytes) }
  validates :status, presence: true

  validate :birthdate_between_zero_and_125_years_ago

  before_validation :cleasing

  accepts_nested_attributes_for :addresses

  private

  def birthdate_between_zero_and_125_years_ago
    return if birthdate.blank?

    errors.add(:birthdate, :invalid) if birthdate > Date.today || birthdate < 125.years.ago
  end

  def cleasing
    self.health_card_document = health_card_document.to_s.gsub(/\D/, '')
    self.document = document.to_s.gsub(/\D/, '')
    self.phone = phone.to_s.gsub(/\D/, '')
  end
end
