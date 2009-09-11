require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArtistMatcher do
  before(:each) do
    @matcher = ArtistMatcher.new(CHART)
  end
  
  describe "matching artists" do
    it "should match Sugababes" do
      @matcher.match('Sugababes').should == 'Sugababes'
    end
    
    it "should match Sugababe" do
      @matcher.match('Sugababe').should == 'Sugababes'
    end
    
    it "should match Jay-Z Ft Rihanna &amp; Kanye West" do
      @matcher.match("Jay-Z Ft Rihanna &amp; Kanye West").should == 'Jay-Z Ft Rihanna & Kanye West'
    end
    
    it "should not match monkey" do
      @matcher.match('monkey').should be_nil
    end
  end
end
