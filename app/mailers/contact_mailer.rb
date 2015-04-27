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
  
  def distribution_client_confirmation(press_release)
    @press_release = press_release
    #@newsroom = @press_release.newsroom
    mail(from: "hello@newshubby.com", to: @press_release.newsroom.email, subject: "NewsHubby Press release distribution service")
  end
  
  
  def welcome_mail(newsroom)
    @newsroom = newsroom
    #@newsroom = @press_release.newsroom
    mail(from: "hello@newshubby.com", to: @newsroom.email, subject: "Welcome to NewsHubby")
  end
  
end
