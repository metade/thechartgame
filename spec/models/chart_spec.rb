require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Chart do
  
  describe "updating chart" do
    describe "when a chart exists this week" do
      before(:each) do
        Factory(:chart)
        @chart = Chart.update_chart
      end
      
      it "should return nil" do
        @chart.should be_nil        
      end
    end
    
    describe "when no chart exists this week" do
      before(:each) do
        @today = Date.today
        chart = %w(one two three four five six seven).map { |s| "<td><h4>#{s}</h4></td>"}.join
        Chart.expects(:open).
          with('http://www.bbc.co.uk/radio1/chart/albums.shtml').
          returns(chart)
        Chart.expects(:open).
          with('http://www.bbc.co.uk/radio1/chart/singles.shtml').
          returns(chart)
        @chart = Chart.update_chart
      end
      
      it "should return return the chart with this week's date" do
        @chart.year.should == @today.year
        @chart.week.should == @today.cweek
      end
      
      it "should return return the chart with this week albums chart" do
        @chart.albums.should == %w(one two three four five six seven)
      end
      
      it "should return return the chart with this week singles chart" do
        @chart.singles.should == %w(one two three four five six seven)
      end
      
      it "should have no predictions" do
        @chart.predictions.should be_empty
      end
      
      it "should have no unscored predictions" do
        @chart.unscored_predictions.should be_empty
      end
      
      describe "when predictions exist" do
        before(:each) do
          @unscored = Factory(:prediction)
          @scored = Factory(:prediction, :score => 10.0)
        end
        
        it "should have 2 predictions" do
          @chart.predictions.should == [@unscored, @scored]
        end
        
        it "should have 1 unscored prediction" do
          @chart.unscored_predictions.should == [@unscored]
        end
        
        describe "scoring predictions" do
          before(:each) do
            @chart.score_predictions!
            @unscored.reload
          end
          
          it "should set the matched artists on the unscored prediction" do
            @unscored.artists.should == %w(one two three four five)
          end
          
          it "should set the score on the unscored prediction" do
            @unscored.score.should == 15
          end
        end
      end
    end
  end
end
