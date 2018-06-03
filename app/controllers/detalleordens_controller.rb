class DetalleordensController < ApplicationController
  before_action :set_detalleorden, only: [:show, :edit, :update, :destroy]

  # GET /detalleordens
  # GET /detalleordens.json
  def index
    @detalleordens = Detalleorden.all
  end

  # GET /detalleordens/1
  # GET /detalleordens/1.json
  def show
  end

  # GET /detalleordens/new
  def new
    @detalleorden = Detalleorden.new
  end

  # GET /detalleordens/1/edit
  def edit
  end

  # POST /detalleordens
  # POST /detalleordens.json
  def create
    @detalleorden = Detalleorden.new

    respond_to do |format|
      if @detalleorden.save
        format.html { redirect_to @detalleorden, notice: 'Detalleorden was successfully created.' }
        format.json { render :show, status: :created, location: @detalleorden }
      else
        format.html { render :new }
        format.json { render json: @detalleorden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalleordens/1
  # PATCH/PUT /detalleordens/1.json
  def update
    respond_to do |format|
      if @detalleorden.update(detalleorden_params)
        format.html { redirect_to @detalleorden, notice: 'Detalleorden was successfully updated.' }
        format.json { render :show, status: :ok, location: @detalleorden }
      else
        format.html { render :edit }
        format.json { render json: @detalleorden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalleordens/1
  # DELETE /detalleordens/1.json
  def destroy
    @detalleorden.destroy
    respond_to do |format|
      format.html { redirect_to detalleordens_url, notice: 'Detalleorden was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalleorden
      @detalleorden = Detalleorden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detalleorden_params
      params.require(:detalleorden).permit(:id_orden, :id_producto, :cant, :precio, :id_tipo, :chequeado, :id)
    end
end
