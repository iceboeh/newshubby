class ContactMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def contact_mail(contact)
    @contact = contact
    mail(to: "hello@newshubby.com", reply_to: @contact.email, subject: "Newshubby Contact Form")
  end


  def distribution_mail(press_release)
    @press_release = press_release
    #@newsroom = @press_release.newsroom
    mail(from: @press_release.newsroom.email, to: "alexandra@newshubby.com", subject: "Distribution: #{@press_release.title}")
  end
  
end
