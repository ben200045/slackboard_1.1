class ViewController < ApplicationController
	def home
		
	rescue
		render file: "#{Rails.root}/public/404.html", status: 404
	end
	
end
