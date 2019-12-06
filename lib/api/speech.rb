module Speech
    require 'net/http'
    require 'json'

    ocp_apim_subscription_key = "2c7952cd710e4c34a3ac9e629ed950ef"
    cognitive_sevices_url = "https://rocketspeakerrecognition.cognitiveservices.azure.com/spid/v1.0/identify?identificationProfileIds/"
    speaker_recognition_url = "https://westus.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?"

    def self.create_profile(language)
        uri = URI(cognitive_sevices_url)
        uri.query = URI.encode_www_form({})

        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = ocp_apim_subscription_key
        # Request body
        request.body = {
            "locale": language
        }

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        JSON.parse(response.body)['identificationProfileId'];
    end

    def self.delete_profile(profile_id)
        uri = URI(cognitive_sevices_url + profileId)
        uri.query = URI.encode_www_form({})

        request = Net::HTTP::Delete.new(uri.request_uri)
        request['Ocp-Apim-Subscription-Key'] = ocp_apim_subscription_key

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        JSON.parse(response.body)['identificationProfileId'];
    end

    def self.enroll_profile(profile_id, audio)
        @audio = params['Attachment']
        uri = URI( cognitive_sevices_url + profile_id + '/enroll')

        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'audio/vnd.wave'
        request['Ocp-Apim-Subscription-Key'] = ocp_apim_subscription_key
        request.body = File.read(audio.path)

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        response.header['operation-location']
    end

    def self.get_operation_status(operation_location)
        uri = URI(operation_location)
        uri.query = URI.encode_www_form({})

        request = Net::HTTP::Get.new(uri.request_uri)
        request['Ocp-Apim-Subscription-Key'] = ocp_apim_subscription_key

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        JSON.parse(response.body)['status']
    end

    def self.transpile

    end

    def self.recognize_profile
    end

    def recognize(audio, language)
        uri = URI(speaker_recognition_url + 'language=' + language + '&format=detailed')

        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'audio/vnd.wave'
        request['Ocp-Apim-Subscription-Key'] = ocp_apim_subscription_key
        request.body = File.read(audio.path)

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        result = JSON.parse(response2.body)

        redirect_to identified_profile_path(operationnal_status: result['status'], identifiedId: result['processingResult']['identifiedProfileId'], identifiedName: identifiedProfile.name, identifiedLanguage: identifiedProfile.language, confidence: result['processingResult']['confidence'], text: result2['DisplayText'])
    end

end