module ApplicationHelper
	def title
		base_title = "Study Hall Application"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
