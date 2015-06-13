class ReviewsController < ApplicationController

  before_action :authenticate_user!


  def edit
    @review = Review.find(params[:id])
    @place = @review.place
  end

  def create
    @review = current_user.reviews.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to place_path(@review.place), notice: 'review was successfully created.' }
      else
        format.html { redirect_to place_path(@review.place), notice: "Something went wrong" }
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to place_path(@review.place), notice: 'review was successfully updated.' }
      else
        format.html { redirect_to place_path(@review.place), notice: "Something went wrong" }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to place_path(@review.place), notice: 'Place was successfully destroyed.' }
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :place_id, :score, :content)
  end

end
