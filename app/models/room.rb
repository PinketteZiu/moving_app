class Room < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :boxes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  scope :with_counts, -> {
    left_joins(:items, :boxes)
      .group(:id)
      .select('rooms.*, COUNT(DISTINCT items.id) as items_count, COUNT(DISTINCT boxes.id) as boxes_count')
  }
end
