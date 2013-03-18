class Contact
	include ActiveAttr::Model

	attribute :name
	attribute :email
	attribute :content

	attr_accessible :name, :email, :content

	validates_presence_of :name, :content
	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}(\.[a-z0-9]{2,4})?$/i
	validates_length_of :content, :maximum => 1000
end