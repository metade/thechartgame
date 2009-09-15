Factory.define :user do |u|
  u.username 'user'
end


Factory.define :chart do |c|
  c.albums %w(one two three four five six seven)
  c.singles %w(one two three four five six seven)
  
  c.year Date.today.year
  c.week Date.today.cweek
end

Factory.define :prediction do |p|
  p.guess "one, two, three, four, five"
  
  p.year Date.today.year
  p.week Date.today.cweek
  
  p.association :user
end

