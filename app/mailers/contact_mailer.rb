class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def contact_mail(contact)
    @contact = contact
    mail(to: "hello@newshubby.com", reply_to: @contact.email, subject: "Newshubby Contact Form")
  end
end
