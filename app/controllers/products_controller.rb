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
  end

 
  def show

    if @product.reviews.blank?
			@average_review = 0
		else
			@average_review = @product.reviews.average(:rating).round(2)
    end
    
  end
 
  def new
    @product = Product.new
    @product = current_user.products.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  
  def edit
   @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  
  def create
    @product = current_user.products.build(product_params)
    @product.category_id = params[:category_id]
    #@product.user_id = current_user.id

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
        render 'edit'
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
   redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :product_img, )
    
  end

  def find_product
    @product = Product.find(params[:id])
    
  end
  
end
