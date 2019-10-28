require 'sendgrid-ruby'
include SendGrid

from = SendGrid::Email.new(email: @lead.email)
to = SendGrid::Email.new(email: 'etienne.bosse@hotmail.fr')
subject = SendGrid::Subject.new(type: 'text/plain', value: 'Greetings' + @lead.full_name)
content = SendGrid::Content.new(type: 'text/plain', value:
     'We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project' + @lead.building_project_name + '.'
     </br>'
     A representative from our team will be in touch with you very soon. We look forward to demonstrate the value of our solutions and help you choose the appropriate product given your requirements.
     '</br>'
     We’ll Talk soon
     '</br>'
     The Rocket Team
     ')
mail = SendGrid::Mail.new(from, to, subject, content)

sg = SendGrid::API.new(api_key: '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')
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.parsed_body
puts response.headers