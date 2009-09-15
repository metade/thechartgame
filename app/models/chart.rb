class Chart < ActiveRecord::Base
  serialize :albums
  serialize :singles
  
  def self.update_chart
    today = Date.today
    year, week = today.year, today.cweek
    return if Chart.find_by_year_and_week(year, week)
    
    doc = Hpricot(open('http://www.bbc.co.uk/radio1/chart/albums.shtml'))
    albums = (doc/'//td/h4').map { |e| e.inner_html }
    
    doc = Hpricot(open('http://www.bbc.co.uk/radio1/chart/singles.shtml'))
    singles = (doc/'//td/h4').map { |e| e.inner_html }
    
    Chart.create(
      :year => year,
      :week => week,
      :albums => albums,
      :singles => singles)
  end
  
  def predictions
    Prediction.find_all_by_year_and_week(year, week)
  end
  
  def unscored_predictions
    Prediction.find_all_by_year_and_week(year, week, :conditions => "score IS NULL")
  end
  
  def matcher
    @matcher ||= ArtistMatcher.new(singles)
  end
  
  def scorer
    @scorer ||= PredictionScorer.new(singles)
  end
  
  def score_predictions!
    
    unscored_predictions.each do |prediction|
      artists = matcher.match_string(prediction.guess)
      prediction.update_attributes(:score => scorer.score(artists), :artists => artists)
    end
  end
end
