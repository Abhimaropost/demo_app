module HomesHelper
	def contact_helper
	    current_user  ? (link_to "Contact Us", {controller: "/homes", action: "contact_us"}, class: "contact-us-link")  : "Contact Us"
	end
end
