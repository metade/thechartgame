Factory.define :chart do |c|
  c.albums %w(one two three)
  c.singles %w(one two three)
  
  c.year Date.today.year
  c.week Date.today.cweek
end
