class Item < ApplicationRecord
  belongs_to :room
  belongs_to :box, optional: true

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :condition, inclusion: { in: %w[excellent good fair poor] }

  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }
  scope :by_condition, ->(condition) { where(condition: condition) }
  scope :by_room, ->(room_id) { where(room_id: room_id) }
  scope :by_box, ->(box_id) { where(box_id: box_id) }
  scope :unboxed, -> { where(box_id: nil) }

  def condition_badge_class
    case condition
    when 'excellent' then 'bg-success'
    when 'good' then 'bg-primary'
    when 'fair' then 'bg-warning'
    when 'poor' then 'bg-danger'
    end
  end

  def condition_text
    case condition
    when 'excellent' then 'Excellent'
    when 'good' then 'Bon'
    when 'fair' then 'Acceptable'
    when 'poor' then 'Mauvais'
    end
  end
end
