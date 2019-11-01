class LeadsMailer < ApplicationMailer
    default from: 'no-reply@rocketelevatorscanada.com' #ABC@domain.name

    def leads_email(lead)
        @lead = lead
 
        mail(:to => lead.email,
             subject: "GGG: #{@lead.email}")
        end
end
