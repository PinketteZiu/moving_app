class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  private

  def dashboard_stats
    @stats = {
      total_rooms: Room.count,
      total_items: Item.count,
      total_boxes: Box.count,
      total_value: Item.sum(:value) || 0,
      rooms_progress: Room.includes(:items).map do |room|
        {
          name: room.name,
          progress: room.completion_percentage,
          items_count: room.items.count
        }
      end
    }
  end
end
