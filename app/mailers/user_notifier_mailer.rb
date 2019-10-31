class UserNotifierMailer < ApplicationMailer

  default :from => 'rocketelevators@rocketelevatorscanada.com' #ABC@domain.name

  def send_lead_email(lead)
    @lead = lead
    mail( 
      :to => @lead.email,
      :subject => 'Greetings ' + @lead.full_name #Email Subject (Title)
    )
  end
      
end
