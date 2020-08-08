class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /products
  # GET /products.json
  def index
    if params[:category].blank?
              @products = Product.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @products = Product.where(:category_id => @category_id).order("created_at_DESC")
  end

  # GET /products/1
  # GET /products/1.json
  def show
    
  end

  # GET /products/new
  def new
    
    @product = current_user.products.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  
  def create
    # @product = current_user.products.build(product_params)
    @product = current_user.products.build(product_params)
    @product.category_id = params[:category_id]

      if @product.save
        redirect_to root_path
      else
        render 'new'
      end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      @product.category_id = params[:category_id]
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :product_img, )
    
  end

  def find_product
    @product = Product.find(params[:id])
    
  end
  
  
    
end
end
