class Url < ActiveRecord::Base
  validates :url, presence: true, :format => {:with => URI.regexp}
  validates :short_url, presence: true, uniqueness: true

  def self.shorten
    randomstring = ((('a'..'z').to_a + (0..9).to_a)*3).shuffle[0,5.to_i].join
    "#{randomstring}.jf"
  end
end
