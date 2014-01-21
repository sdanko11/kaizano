class ContactUs < ActionMailer::Base
  default from: "from@example.com"

  def contact_us_message(contact_form)

    mail to: 'stevedanko1@gmail.com',
    content_type: "text/html",
    body: "From #{contact_form.name}, Message: #{contact_form.message}",
    subject: contact_form.subject,
    from: contact_form.email_address
  end

end
