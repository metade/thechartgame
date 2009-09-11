require 'artist_matcher'

chart_path = (RAILS_ENV=='test') ? 
  File.join(RAILS_ROOT, 'spec', 'fixtures', 'chart.yml') :
  File.join(RAILS_ROOT, 'tmp', 'chart.yml')

CHART = YAML.load(File.read(chart_path))
