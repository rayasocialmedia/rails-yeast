class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    if user_signed_in?
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new params[:contact]
    if @contact.valid?
      ContactMailer.support_message(@contact).deliver
      redirect_to root_url, notice: t("resources.contact_sent")
    else
      render :new
    end
  end
end