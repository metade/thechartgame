task :cron => :environment do
  puts "Trying to update chart..."
  chart = Chart.update_chart
  if chart
    puts "New chart: #{chart.inspect}"
  else
    puts "No new chart"
  end
end
