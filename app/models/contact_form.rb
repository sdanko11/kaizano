class ContactForm < ActiveRecord::Base
  
  validates_presence_of :message

  validates_presence_of :email_address

  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validates_presence_of :subject
  
end
