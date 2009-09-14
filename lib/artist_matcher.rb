require 'text'

class ArtistMatcher
  def initialize(chart)
    @chart = chart
    @index = chart.map { |a| escape_string(a) }
  end
  
  def match(artist)
    scores = {}
    search = escape_string(artist)
    @index.each_with_index { |str,i| scores[i] = Text::Levenshtein.distance(search, str) }
    
    position, distance = scores.sort { |a,b| a.last <=> b.last }.first
    
    if (artist_matched(search, distance))
      @chart[position]
    else
      nil
    end
  end
  
  def match_all(array)
    array.map { |s| match(s) }
  end
  
  def match_string(string)
    match_all(string.split(','))
  end
  
  protected
  
  def escape_string(string)
    string.gsub(/\W/, '').downcase
  end
  
  def artist_matched(search, distance)
    if search.size <= 4
      (distance == 0)
    else
      min, max = [search.size, distance].sort
      (min/max.to_f) < 0.8
    end
  end
end
