class ContactFormsController < ApplicationController

  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.create(contact_form_params)
    if @contact_form.save
      ContactUs.contact_us_message(@contact_form).deliver
      flash[:mail_sent] = "Message Sent, Thanks"
      redirect_to new_contact_form_path
    else
      render :new
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :subject, :email_address, :message)
  end

end