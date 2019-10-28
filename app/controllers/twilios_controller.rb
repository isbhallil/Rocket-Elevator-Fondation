class TwiliosController < ApplicationController
  before_action :set_twilio, only: [:show, :edit, :update, :destroy]

  # GET /twilios
  # GET /twilios.json
  def index
    @twilios = Twilio.all
  end

  # GET /twilios/1
  # GET /twilios/1.json
  def show
  end

  # GET /twilios/new
  def new
    @twilio = Twilio.new
  end

  # GET /twilios/1/edit
  def edit
  end

  # POST /twilios
  # POST /twilios.json
  def create
    @twilio = Twilio.new(twilio_params)

    respond_to do |format|
      if @twilio.save
        format.html { redirect_to @twilio, notice: 'Twilio was successfully created.' }
        format.json { render :show, status: :created, location: @twilio }
      else
        format.html { render :new }
        format.json { render json: @twilio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twilios/1
  # PATCH/PUT /twilios/1.json
  def update
    respond_to do |format|
      if @twilio.update(twilio_params)
        format.html { redirect_to @twilio, notice: 'Twilio was successfully updated.' }
        format.json { render :show, status: :ok, location: @twilio }
      else
        format.html { render :edit }
        format.json { render json: @twilio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twilios/1
  # DELETE /twilios/1.json
  def destroy
    @twilio.destroy
    respond_to do |format|
      format.html { redirect_to twilios_url, notice: 'Twilio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twilio
      @twilio = Twilio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twilio_params
      params.fetch(:twilio, {})
    end
end
