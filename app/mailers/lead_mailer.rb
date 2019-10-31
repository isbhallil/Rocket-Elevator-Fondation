class LeadMailer < ApplicationMailer
    default from: 'no-reply@rocketelevatorscanada.com' #ABC@domain.name
    layout 'mailer'

   def send_lead_email(lead)
       @lead = lead

       mail(:to => lead.email,
            subject: "New User Signup: #{@lead.email}")
       end
end
