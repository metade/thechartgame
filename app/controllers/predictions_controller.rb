class PredictionsController < ApplicationController
  def index
    @predictions = Prediction.find(:all)
  end
  
  def new
    @prediction = Prediction.new(:user => User.new)
  end
  
  def create
    @prediction = Prediction.new(params[:prediction])
    if @prediction.save
      redirect_to predictions_path
    else
      render :action => "new"
    end
  end
  
  def score
    Prediction.score_all
    redirect_to predictions_path
  end
end
