class ReviewsController < ApplicationController
  before_action :find_product

 
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
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
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
    
end
