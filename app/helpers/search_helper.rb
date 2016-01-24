module SearchHelper
		require 'rubygems'
require 'nokogiri'
require 'open-uri'
	def mprint(mrurl)
	
@murl=[]
doc = Nokogiri::HTML(open(mrurl))
doc.css("p.bpadding > a").each do |item|
  #url = item.at_css(".a").text
  #price = item.at_css(".PriceCompare .BodyS, .PriceXLBold").text[/\$[0-9\.]+/]
  #puts "#{title} - #{price}"
  #puts item.at_css(".prodLink")[:href]
  @murl = item[:href]
end
return @murl
	end

	def gtest(st)
		#redirect_to "www.google.com"
		@js = st
		return @js
	end

end
