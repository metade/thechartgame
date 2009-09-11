class PredictionScorer
  def initialize(chart)
    @chart = chart
    @index = {}
    @chart.each_with_index { |a,i| @index[a] = i }
  end
  
  def score(guesses, size=5)
    c, g = find_guesses(guesses, size)
    c.compact!
    g.compact!
    
    return 0 if (c.empty? or g.empty?)
    return 1 if (c.size==1 or g.size==1)
    
    s = self.class.calc_kendall_tau(c, g)
    g.size + ((s+1) * g.size)
  end
  
  protected 
  
  def find_guesses(guesses, size=5)
    g = guesses.map { |g| (@index[g] and @index[g] < size) ? g : nil }
    c = @chart[0,size].map { |c| g.index(c) ? c : nil }
    [c, g]
  end
  
  def self.calc_kendall_tau(rank1, rank2)
    p, positions = 0, rank2.map { |r| rank1.index(r)+1 }
    positions.each_with_index { |x,i| 
      positions[i...rank1.size].each { |r| p += 1 if r > x } 
    }
    t = (4*p)/(rank1.size * (rank1.size-1)).to_f - 1
  end
  
  def self.calc_spearman(rank1, rank2)
    n, sum = rank1.size, 0
    rank1.each_with_index { |x,i| 
      d = (i-rank2.index(x)).abs
      sum += (d*d)
    }
    1 - ((6 * sum).to_f/(n*((n*n)-1))).to_f
  end
end
