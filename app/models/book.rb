class Book < ApplicationRecord
  belongs_to :author
  validates :title, :publication_date, presence: true
end
