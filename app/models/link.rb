class Link < ApplicationRecord
  belongs_to :user
  validates :slug, uniqueness: { case_sensitive: true }
end
