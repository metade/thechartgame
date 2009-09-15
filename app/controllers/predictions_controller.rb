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
  
  def fetch
    Prediction.fetch_from_twitter
    chart = Chart.update_chart
    chart.score_predictions! if chart
    redirect_to predictions_path
  end
end
