require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PredictionScorer do
  before(:each) do
    @scorer = PredictionScorer.new([:a,:b,:c,:d,:e,:f,:g,:h,:i,:j,:a])
  end
  
  describe "finding guesses" do
    it "should return work for a correct guess" do
      @scorer.send(:find_guesses, [:a,:b,:c,:d,:e]).should == [[:a,:b,:c,:d,:e], [:a,:b,:c,:d,:e]]
    end
    
    it "should work for a guess that had the right objects in wrong order" do
      @scorer.send(:find_guesses, [:e,:d,:c,:b,:a]).should == [[:a,:b,:c,:d,:e], [:e,:d,:c,:b,:a]]
    end
    
    it "should work for a partially correct guess" do
      @scorer.send(:find_guesses, [:b,:a,:h,:c,:d]).should == [[:a,:b,:c,:d,nil], [:b,:a,nil,:c,:d]]
    end
    
    it "should work for a completely incorrect guess" do
      @scorer.send(:find_guesses, [:f,:g,:h,:i,:j]).should == [[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil]]
    end
    
    it "should work for a completely incorrect guess when thare are rogue elements" do
      @scorer.send(:find_guesses, [:f,:g,:z,:i,:j]).should == [[nil,nil,nil,nil,nil],[nil,nil,nil,nil,nil]]
    end
    
  end
  
  describe "scoring guesses" do
    it "should return a high score for a correct guess" do
      @scorer.score([:a,:b,:c,:d,:e]).should == 15
    end
    
    it "should return a highish score for a slightly incorrect guess" do
      @scorer.score([:a,:b,:c,:e,:d]).should == 14
    end
    
    it "should return a low score for guessing the right artists in the wrong order" do
      @scorer.score([:d,:c,:b,:a,:e]).should == 9
    end
    
    it "should return 0 for guessing none of the right artists" do
      @scorer.score([:v,:w,:x,:y,:z,]).should == 0
    end
  end
  
  describe "scoring real guesses" do
    before(:each) do
      @scorer = PredictionScorer.new(CHART)
    end
    
    it "should return a low score for guessing one artist" do
      @scorer.score(['Sugababes']).should == 1
    end
    
    it "should return a low score for guessing one or two artists" do
      @scorer.score(['Sugababes', 'Jay-Z Ft Rihanna & Kanye West']).should == 2
    end
    
    it "should return a high score for a perfect guess" do
      @scorer.score(['Jay-Z Ft Rihanna & Kanye West', 'Sugababes', 'David Guetta Ft Akon', 'Dizzee Rascal', 'Black Eyed Peas']).should == 15
    end
  end
end
