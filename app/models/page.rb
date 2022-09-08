class Page < ApplicationRecord
  has_many :events

  validates :url, presence: true, allow_blank: false, uniqueness: true
end
