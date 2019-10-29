class UserNotifierMailer < ApplicationMailer

  default :from => 'rocketelevators@rocketgb.best'

  def send_lead_email(lead)
    @lead = lead
    mail( 
      :to => @lead.email,
      :subject => 'Greetings ' + @lead.full_name
    )
  end
      
end
