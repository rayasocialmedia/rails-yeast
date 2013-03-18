class ContactMailer < ActionMailer::Base
  default to: "public@osharek.com"

  def support_message contact
  	@contact = contact
  	mail(:from => contact.email, :subject => "support request")
  end
end
