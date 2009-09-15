task :cron => :environment do
  puts "Fetching new predictions from twitter"
  Prediction.fetch_from_twitter
  
  puts "Trying to update chart..."
  chart = Chart.update_chart
  if chart
    puts "New chart: #{chart.inspect}"
    chart.score_predictions!
  else
    puts "No new chart"
  end
end
