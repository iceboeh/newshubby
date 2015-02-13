class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def contact_mail(contact)
    @contact = contact
    mail(to: "hello@newshubby.com", reply_to: @contact.email, subject: "Newshubby Contact Form")
  end


  def distribution_mail(newsroom)
    @newsroom = newsroom
    mail(to: "robert@newshubby.com", reply_to: @newsroom.email, subject: "NewsHubby: Send to Press")
  end
  
end
