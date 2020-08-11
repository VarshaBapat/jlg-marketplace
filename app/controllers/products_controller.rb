class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  # GET /products
  # GET /products.json
  def index
        # if params[:category].blank?
        #       @products = Product.all.order("created_at DESC")
        # else
        #       @category_id = Category.find_by(name: params[:category]).id
        #       @products = Product.where(:category_id => @category_id).order("created_at_DESC")
        # end
    @products = Product.all
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
    # @product = current_user.products.build
    # @categories = Category.all.map{ |c| [c.name, c.id] }
    @categories = Category.all
    puts "-----------------------------------------"
    puts @categories
  end



   def create
    
    # puts product_params
    # @product = current_user.products.build(product_params)
    # @product = Product.new(product_params)
    # @product = Product.new()
    # @product.name = product_params[:name]
    # @product.description = product_params[:description]
    # @product.price = product_params[:price]

    # category = Category.find_by(id: product_params[:category_id])
    # @product.category = category
    # @product.user = current_user
    # # @product.category_id = params[:category_id]
    # # @product.category = params[:category_id]
    # #@product.user_id = current_user.id
    # puts "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    # puts @product.inspect
    # puts @product.name
    # puts @product.description
    # puts @product.price
    # puts @product.category
    # puts @product.user

    @product = Product.create(product_params)
    redirect_to root_path

      # if @product.save
      #   redirect_to root_path
      # else
      #   redirect_to :new
      # end
  end

  # def create
  #   # link the current user to the student when they finish filling in all their details
  #   @student = Student.new(student_params)
  #   @student.user = current_user
  #   authorize! :read, @student, :message => "You do not have authorization to view that content."

  #   if @student.save
  #     redirect_to edit_student_path(current_user.student.id), :notice => "Thanks for signup up"
  #   else
  #     render :new, :alert => "Something went wrong, try again"
  #   end

  # end
  
  def edit
  #  @categories = Category.all.map{ |c| [c.name, c.id] }
   @categories = Category.all
  end

  
  def update
    
      @product.category_id = params[:category_id]
      if @product.update(product_params)
       redirect_to product_path(@product)
      else
        render 'edit'
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
          params.require(:product).permit(:name, :description, :price, :category_id, :product_img )
          
        end

        def find_product
          @product = Product.find(params[:id])
          
        end
  
end
