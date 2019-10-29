class UserNotifierMailer < ApplicationMailer

  default :from => 'rocketelevators@codeboxx.biz'

  def send_lead_email(lead)
    @lead = lead
    mail( 
      :to => @lead.email,
      :subject => 'Greetings ' + @lead.full_name
    )
  end
      
end
