class SearchController < ApplicationController
require 'rubygems'
require 'nokogiri'
require 'open-uri'

	def index
		@aproduct = []
		@tproduct = []
		@fproduct = []
		@uproduct = []
		@iproduct = []
		@search_ca = params[:category]
		@search_kw = params[:search]
		if(@search_kw)
			url1 = "http://api.pricecheckindia.com/feed/product/#{@search_ca}/#{@search_kw.split.join("+")}.xml?user=rockerkh&key=IEGENVHHZTVSRMGH"
			doc = Nokogiri::XML(open(url1))
			node = doc.xpath("/data")

			node.children.each do |item|
				p_price = 0
				s_price = 0
				s_pro = ""
				p_pro = ""
				p_img = ""
				s_img = ""
				p_logo = ""
				s_logo = ""
				item.children.each do |product|
					if(product['website'] == "amazon")
						p_logo = 'https://lh3.googleusercontent.com/-c9bKgaRfC3Q/AAAAAAAAAAI/AAAAAAAAJUE/Eo2MLCqyiZs/photo.jpg'
						p_price = product['price'].to_i
						p_pro = product['url']
						p_img = product['image']
					end

					if(product['website'] == "paytm")
						s_logo = 'https://pbs.twimg.com/profile_images/462131260794470400/VFsaWo_G.jpeg'
						s_price = product['price'].to_i
						s_pro = product['url']
						s_img = product['image']
					end

				end

				if(p_price < s_price)
					if(p_price!=0 )
						@aproduct.push(p_logo)
						@fproduct.push(p_price)
						@tproduct.push(item['model'])
						@uproduct.push(p_pro)
						@iproduct.push(p_img)

						#puts "#{item['model']} = #{p_price}"
					elsif(s_price!=0)
						@aproduct.push(s_logo)
						@fproduct.push(s_price)
						@tproduct.push(item['model'])
						@uproduct.push(s_pro)
						@iproduct.push(s_img)
						#puts "#{item['model']} = #{s_price}"
					else
					end
					elsif(s_price < p_price)
						if(s_price!=0)
							@aproduct.push(s_logo)
							@fproduct.push(s_price)
							@tproduct.push(item['model'])
							@uproduct.push(s_pro)
							@iproduct.push(s_img)
							#puts "#{item['model']} = #{s_price}"
						elsif(p_price!=0)
							@aproduct.push(p_logo)
							@fproduct.push(p_price)
							@tproduct.push(item['model'])
							@uproduct.push(p_pro)
							@iproduct.push(p_img)
							#puts "#{item['model']} = #{p_price}"
						else

						end
					else

				end

			end
		end
	end
	def store
		urls = params[:sto]
		sdoc = Nokogiri::HTML(open(urls))
		@murl = ""
		sdoc.css("p.bpadding > a").each do |item|
  			@murl = item[:href]
		end
		redirect_to @murl
	end
end
