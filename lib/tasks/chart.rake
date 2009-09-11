require 'open-uri'
require 'hpricot'

namespace :charts do
  desc "Fetch latest chart data from bbc.co.uk"
  task :fetch do
    doc = Hpricot(open('http://www.bbc.co.uk/radio1/chart/singles.shtml'))
    artists = (doc/'//td/h4').map { |e| e.inner_html }
    File.open(File.join(RAILS_ROOT, 'tmp', 'chart.yml'), 'w') { |f| f.puts(artists.to_yaml) }
  end
end
