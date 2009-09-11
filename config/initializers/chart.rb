require 'artist_matcher'
require 'open-uri'

chart_path = (RAILS_ENV=='test') ? 
  File.join(RAILS_ROOT, 'spec', 'fixtures', 'chart.yml') :
  File.join(RAILS_ROOT, 'tmp', 'chart.yml')

begin
  CHART = YAML.load(File.read(chart_path))
rescue
  doc = Hpricot(open('http://www.bbc.co.uk/radio1/chart/singles.shtml'))
  CHART = (doc/'//td/h4').map { |e| e.inner_html }
end  
