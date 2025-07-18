class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_room, only: [:index, :new, :create]

  def index
    @items = @room.items.includes(:box).order(:name)
  end

  def show
  end

  def new
    @item = @room.items.build
    @boxes = @room.boxes.order(:number)
  end

  def create
    @item = @room.items.build(item_params)

    if @item.save
      redirect_to @room, notice: 'Objet créé avec succès.'
    else
      @boxes = @room.boxes.order(:number)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @boxes = @item.room.boxes.order(:number)
  end

  def update
    if @item.update(item_params)
      redirect_to @item.room, notice: 'Objet mis à jour avec succès.'
    else
      @boxes = @item.room.boxes.order(:number)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    room = @item.room
    @item.destroy
    redirect_to room, notice: 'Objet supprimé avec succès.'
  end

  def search
    @query = params[:q]
    @room_filter = params[:room_id]
    @condition_filter = params[:condition]
    @box_filter = params[:box_id]

    @items = Item.all
    @items = @items.search_by_name(@query) if @query.present?
    @items = @items.by_room(@room_filter) if @room_filter.present?
    @items = @items.by_condition(@condition_filter) if @condition_filter.present?
    @items = @items.by_box(@box_filter) if @box_filter.present?
    @items = @items.unboxed if params[:unboxed] == '1'

    @items = @items.includes(:room, :box).order(:name)
    @rooms = Room.order(:name)
    @boxes = Box.order(:number)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :value, :condition, :box_id, :photo)
  end
end
