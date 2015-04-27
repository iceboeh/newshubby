class RegistrationsController < Devise::RegistrationsController
  def create
    super
    #ContactMailer.welcome_mail(@newsroom).deliver unless @newsroom.invalid?
  end

  protected
    
  def after_sign_up_path_for(newsroom)
    '/introduction/'
  end
end