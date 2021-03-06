class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]
  before_action :set_id_ong, only: [:new, :create, :edit, :update]

  # GET /animals
  # GET /animals.json
  def index
    @ong = Ong.where(user_id: session[:user_id])
    if params[:situacao].present?
      @animals = Animal.where("situacao LIKE ?", "%#{params[:situacao]}%")if params[:situacao].present?
      @animals = @animals.where(ong_id: @ong.ids)
    end
    if params[:nome].present?
      @animals = Animal.where("nome LIKE ?", "%#{params[:nome]}%")if params[:nome].present?
      @animals = @animals.where(ong_id: @ong.ids)
    else
      @animals = Animal.all
      @animals = @animals.where(ong_id: @ong.ids)
    end

  end

  # GET /animals/1
  # GET /animals/1.json
  def show
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end


  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: 'Animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_id_ong
    @id_ong = Ong.all.map{|ong|[ong.id]}
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.require(:animal).permit(:nome, :raca, :especie, :sexo, :peso, :data_nascimento, :situacao, :ong_id)
    end
end
