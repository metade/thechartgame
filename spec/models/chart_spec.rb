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
        Chart.expects(:open).
          with('http://www.bbc.co.uk/radio1/chart/albums.shtml').
          returns('<td><h4>foo</h4></td>')
        Chart.expects(:open).
          with('http://www.bbc.co.uk/radio1/chart/singles.shtml').
          returns('<td><h4>bar</h4></td>')
        @chart = Chart.update_chart
      end
      
      it "should return return the chart with this week's date" do
        @chart.year.should == Date.today.year
        @chart.week.should == Date.today.cweek
      end
      
      it "should return return the chart with this week albums chart" do
        @chart.albums.should == ['foo']
      end
      
      it "should return return the chart with this week singles chart" do
        @chart.singles.should == ['bar']
      end
    end
  end
end
