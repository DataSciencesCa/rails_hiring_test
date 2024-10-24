class PollingLocation < ApplicationRecord
  belongs_to :riding
  has_many :polls, dependent: :nullify

  validates :title, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validate :validate_postal_code
  validate :validate_uniqueness
  
  after_validation :format_postal_code

  def format_postal_code
    self.postal_code = self.postal_code.upcase.scan(/[A-Z0-9]/).insert(3, ' ').join if self.postal_code.present?
  end

  def validate_postal_code
    unless self.postal_code.present? && /[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d/.match?(self.postal_code.upcase)
      errors.add(:postal_code, "must be valid")
    end
  end

  def validate_uniqueness
    exists = PollingLocation
               .where(riding_id: self.riding_id,
                      title: self.title,
                      address: self.address,
                      city: self.city,
                      postal_code: self.postal_code).count == 0
    errors.add(:duplication, "- Polling Location must be unique") unless exists
  end
end
