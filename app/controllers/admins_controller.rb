class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
    authorize! :read, @admins, :message => "You do not have authorization to view that content."
  end

    # GIVE ADMINS ACCESS TO SEE ALL USERS
  def users
    @users = User.all
    authorize! :read, @users, :message => "You do not have authorization to view that content."
  end

  # GIVE ADMINS ACCESS TO DELETE A USER AND ITS ASSOCIATED USER
   def admin_delete_user
    @user = User.find_by(id: params[:id])
    authorize! :read, @user, :message => "You do not have authorization to view that content."

    if @user&.destroy
      redirect_to users_path, notice: 'User successfully deleted'
    else
      redirect_to users_path, alert: 'Something went wrong and user was not deleted.'
    end
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    authorize! :read, @admin, :message => "You do not have authorization to view that content."
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    authorize! :read, @admin, :message => "You do not have authorization to view that content."

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
      authorize! :read, @admin, :message => "You do not have authorization to view that content."
    end

    # Only allow a list of trusted parameters through.
    def admin_params
     params[:admin][:first_name].capitalize!
      params[:admin][:last_name].capitalize!
      params.require(:admin).permit(:first_name, :last_name)
    end
end
