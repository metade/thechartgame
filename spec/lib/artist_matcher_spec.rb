require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# sarah calvin harris, muse, peter andre, beyonce, the kooks  Calvin Harris, JLS, Beyonce, Beyonce, Little Boots  0.0
# david jay-z, sugaerbabes, david guetta wilson, black eyed peas, dizzie rascal JLS, Sugababes, David Guetta Ft Akon, Black Eyed Peas, Dizzee Rascal  10.6666666666667
# channon mika  Mika  1.0

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
    
    it "should not match Jay-Z to JLS" do
      @matcher.match('Jay-Z').should be_nil
    end
    
    it "should not match Muse to JLS" do
      @matcher.match('Muse').should be_nil
    end
    
  end
end
