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
end
