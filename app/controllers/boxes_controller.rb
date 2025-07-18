class BoxesController < ApplicationController
before_action :set_box, only: [:show, :edit, :update, :destroy, :label]
  before_action :set_room, only: [:index, :new, :create]

  def index
    @boxes = @room.boxes.includes(:items).order(:number)
  end

  def show
  end

  def new
    @box = @room.boxes.build
    # Générer automatiquement le prochain numéro
    last_box = Box.order(:number).last
    @box.number = last_box ? "#{last_box.number.to_i + 1}" : "1"
  end

  def create
    @box = @room.boxes.build(box_params)

    if @box.save
      redirect_to @room, notice: 'Carton créé avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @box.update(box_params)
      redirect_to @box.room, notice: 'Carton mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    room = @box.room
    @box.destroy
    redirect_to room, notice: 'Carton supprimé avec succès.'
  end

  def label
    respond_to do |format|
      format.html { render layout: false }
      format.pdf do
        # Ici tu pourrais ajouter la génération PDF avec wicked_pdf
        render html: render_to_string(template: 'boxes/label', layout: false)
      end
    end
  end

  def search
    @query = params[:q]
    @room_filter = params[:room_id]
    @destination_filter = params[:destination]

    @boxes = Box.all
    @boxes = @boxes.search_by_number(@query) if @query.present?
    @boxes = @boxes.by_room(@room_filter) if @room_filter.present?
    @boxes = @boxes.by_destination(@destination_filter) if @destination_filter.present?

    @boxes = @boxes.includes(:room, :items).order(:number)
    @rooms = Room.order(:name)
  end

  private

    def set_box
      @box = Box.find(params[:id])
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    def box_params
      params.require(:box).permit(:number, :description, :destination_room)
    end
end
