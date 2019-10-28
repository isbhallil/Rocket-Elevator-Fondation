class LeadNotifierMailer < ApplicationMailer

  default :from => 'etienne.bosse@hotmail.fr'

  # send a lead email to the lead, pass in the lead object that contains the lead's email address
  def send_lead_email(lead)
    @lead = lead
    mail( :to => @lead.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
      
end
