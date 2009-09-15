class PredictionsController < ApplicationController
  def index
    @predictions = Prediction.find(:all)
  end
  
  def fetch
    Prediction.fetch_from_twitter
    chart = Chart.update_chart
    chart.score_predictions! if chart
    redirect_to predictions_path
  end
end
