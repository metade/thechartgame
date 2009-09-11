class Prediction < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user
  
  validates_length_of :guess, :minimum => 1
  validates_length_of :guess, :maximum => 140
  
  serialize :artists
  
  def self.score_all(chart=CHART)
    matcher, scorer = ArtistMatcher.new(chart), PredictionScorer.new(chart)
    predictions = Prediction.find(:all, :conditions => "score IS NULL")
    predictions.each do |prediction|
      artists = matcher.match_string(prediction.guess)
      prediction.update_attributes(:score => scorer.score(artists), :artists => artists)
    end
  end
  
  def user_attributes=(params)
    self.user = User.find_or_create_by_username(params[:username], params) unless params[:username].blank?
  end
end
