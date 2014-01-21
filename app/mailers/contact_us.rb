class ContactUs < ActionMailer::Base
  default from: "from@example.com"

  def contact_us_message(contact_form)
    @message = contact_form

    mail to: 'stevedanko1@gmail.com',
    body: contact_form.message,
    subject: contact_form.subject,
    from: contact_form.email_address,
    sender_name: contact_form.name
  end
end
