class UserNotifierMailer < ApplicationMailer

  default :from => 'rocketelevators@rocketgb.best' #ABC@domain.name

  def send_lead_email(lead)
    @lead = lead
    mail( 
      :to => @lead.email,
      :subject => 'Greetings ' + @lead.full_name #Email Subject (Title)
    )
  end
      
end
