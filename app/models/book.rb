class Book < ApplicationRecord
  belongs_to :author
  validates :status, presence: true, inclusion: { in: [ "available", "taken" ] }

  scope :available, -> { where(status: "available") }
  scope :taken, -> { where(status: "taken") }

  def available?
    status == "available"
  end

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "available"
  end
end
