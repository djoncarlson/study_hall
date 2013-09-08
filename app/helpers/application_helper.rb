module ApplicationHelper
	def title
		base_title = "AC After School"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	def logo
	  @logo = image_tag("logo.png", :alt => "Academia Cotopaxi After School", :class => "round")
	end

end

