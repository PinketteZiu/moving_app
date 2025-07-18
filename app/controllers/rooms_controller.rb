class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  
  def index
  @rooms = Room.with_counts.order(:name)
  end

  def show
    @items = @room.items.includes(:box).order(:name)
    @boxes = @room.boxes.includes(:items).order(:number)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: 'Pièce créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Pièce mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: 'Pièce supprimée avec succès.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description)
  end
end
