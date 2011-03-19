module ApplicationHelper
	def title
		base_title = "Study Hall Application"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	def logo
	  @logo = image_tag("logo.png", :alt => "Study Hall Application", :class => "round")
	end

end

