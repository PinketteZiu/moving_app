class Box < ApplicationRecord
  belongs_to :room
  has_many :items, dependent: :nullify

  validates :number, presence: true, uniqueness: true
  validates :description, presence: true
  validates :destination_room, presence: true

  scope :fragile, -> { where(fragile: true) }
  scope :search_by_number, ->(query) { where("number ILIKE ?", "%#{query}%") }
  scope :by_room, ->(room_id) { where(room_id: room_id) }
  scope :by_destination, ->(destination) { where("destination_room ILIKE ?", "%#{destination}%") }

  def items_count
    items.count
  end

  def total_value
    items.sum(:value)
  end

  def fragile_badge
    fragile? ? 'Fragile' : 'Normal'
  end

  def fragile_badge_class
    fragile? ? 'bg-danger' : 'bg-success'
  end

  def total_items
    box_items.sum(:quantity)
  end
end
