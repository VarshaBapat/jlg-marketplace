class SellersController < ApplicationController
  before_action :set_seller, only: [:show, :edit, :update, :destroy]

  # GET /sellers
  # GET /sellers.json
  def index
    @sellers = Seller.all
  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
  end

  # GET /sellers/new
  def new
    @seller = Seller.new
    authorize! :read, @seller, :message => "You do not have authorization to view that content."
  end

  # GET /sellers/1/edit
  def edit
  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params)
    @seller.user = current_user
    authorize! :read, @seller, :message => "You do not have authorization to view that content."

   if @seller.save
    redirect_to edit_seller_path
   else
    render :new
   end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to @seller, notice: 'Seller was successfully updated.' }
        format.json { render :show, status: :ok, location: @seller }
      else
        format.html { render :edit }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy
    @seller.destroy
    respond_to do |format|
      format.html { redirect_to sellers_url, notice: 'Seller was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
      authorize! :read, @seller, :message => "You do not have authorization to view that content."
    end

    # Only allow a list of trusted parameters through.
    def seller_params
       params[:seller][:first_name].capitalize!
      params[:seller][:last_name].capitalize!
      params[:seller][:phone] = format_phone_number(params[:seller][:phone])
      params.require(:seller).permit(:first_name, :last_name, :address, :phone)
    end
end
