class ReviewsController < ApplicationController
  before_action :find_product
  before_action :find_review, only: [:edit, :update, :destory]

 
  def index
    @reviews = Review.all
  end

  
  def show
  end

  def new
    @review = Review.new
  end

  
  def edit
    
  end


  def create
    @review = Review.new(review_params)
    @review.product_id = product.id
    @review.customer_id = current_customer.id
      if @review.save
       redirect_to product_path(@product)
      else
        render "new"
      end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
      if @review.update(review_params)
        redirect_to product_path(@product)
      else
        render 'edit'
      end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    redirect_to product_path(@product)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_review
    #   @review = Review.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_product
      @product = Product.find(params[:product_id])
      
    end

    def find_review
      @review = Review.find(params[:id])
      
    end
    
    
end
