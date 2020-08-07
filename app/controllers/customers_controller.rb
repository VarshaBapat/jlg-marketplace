class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    authorize! :read, @students, :message => "You do not have authorization to view that content."
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find_by(id: params[:id])
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    authorize! :read, @student, :message => "You do not have authorization to view that content."
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @student.user = current_user
    authorize! :read, @customer, :message => "You do not have authorization to view that content."


    if @customer.save
      redirect_to edit_customer_path(current_user.customer.id)
    else
      render :new
    end

  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
      authorize! :read, @customer, :message => "You do not have authorization to view that content."
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params[:customer][:first_name].capitalize!
      params[:customer][:last_name].capitalize!
      params[:customer][:phone] = format_phone_number(params[:customer][:phone])
      params.require(:customer).permit(:first_name, :last_name, :address, :phone)
    end

     def get_all_sellers
      @sellers = Seller.all
      @sellers.map do |ins|
        # ins[:first_name] = "#{ins[:first_name]} #{ins[:last_name]}"
        ins[:address] = ""
        ins[:phone] = ""
      end
      @sellers
    end
end
