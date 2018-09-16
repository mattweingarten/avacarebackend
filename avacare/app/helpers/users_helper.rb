module UsersHelper


  def closest_doctor(lng, lat, doctors)
    c = 5
    lng = lng.to_f
    lat = lat.to_f

    min  = (lng - (doctors[5]['geocode']['location']['lng'].to_f)).abs +
    (lat - (doctors[5]['geocode']['location']['lat'].to_f)).abs
    min_doctor = doctors[5]
    while (c < 10 && c < doctors.length)
      doctor = doctors[c]
      if(doctor)
        distance = (lng - doctor['geocode']['location']['lng'].to_f).abs +
        (lat - doctor['geocode']['location']['lat'].to_f).abs
        if (distance < min)
          min = distance
          min_doctor = doctor
        end
        c +=1
      end
    end
    min_doctor
  end

  def doctor_decider(condition,symptoms)
    result = ""
    accident = condition.accident
    fever = condition.fever

    max_pain = 0
    area_of_max_pain = ""
    rash = false
    bruise = false
    burn = false
    symptoms.each do |symptom|
      if(symptom.type1 = "rash")
        rash = true
      end
      if(symptom.type1 = "bruise")
        bruise = true
      end
      if(symptom.type1 = "burn")
        burn = true
      end
      if symptom.painlevel > max_pain
        max_pain = symptom.painlevel
        area_of_max_pain = symptom.location
      end

    end
    # if(max_pain > 5 && rash)
    # end
    # if(max_pain > 5 && bruise)
    # end

    if(max_pain == 10 || fever >= 40.0)
      result =  "5b33aa692c9dd243556263b8"
    end
    # if(accident && max_pain >= 5)
    #   result = "5b33a6142c9dd24355626324"
    # end
    if(accident && max_pain < 5)
      result = "5b33a6142c9dd2435562632d"
    end
    if(!accident && rash  && max_pain > 5)
      result = "5b33aa692c9dd24355626396"
    end
    if(!accident && rash  && max_pain < 5)
      result = "5b33aa692c9dd2435562637"
    end
    if(!accident && bruise && max_pain > 5)
      result = "5b33a6142c9dd2435562632d"
    end
    if(!burn  && max_pain > 3)
      result =  "5b33a6142c9dd24355626326"
    end
    if(area_of_max_pain == "stomach")
      result = "5b33aa692c9dd243556263ae"
    else
      result = "5b33a6142c9dd2435562633b"
    end

    puts "result:"
    puts result
    result
  end

  def doctors_in_type(type)
    puts "type: "
    puts type
    uri = URI.parse("https://health.axa.ch/hack/api/care-providers?type=#{type}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = ENV["AXA_KEY"]
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    res =  JSON.parse(response.body)
    puts "-----------------------------------------------------------"
    puts "-----------------------------------------------------------"
    puts "-----------------------------------------------------------"
    # puts response.body

    puts "-----------------------------------------------------------"
    puts "-----------------------------------------------------------"


    # puts res['result']
    res['result']
  end


  def medicine_decider(symptoms)
  end

def sendSMS(doctor)
  uri = URI.parse("https://api.twilio.com/2010-04-01/Accounts/AC716e6d32c97cd8be2c2f5513147d19b1/Messages.json")
  request = Net::HTTP::Post.new(uri)
  request.basic_auth("AC716e6d32c97cd8be2c2f5513147d19b1", ENV["TWILIO_KEY"])
  request.set_form_data(
    "Body" => "Hello #{doctor['name']} I would like to make a doctors appointment.",
    "From" => " 41798074683",
    "To" => " 41799203768",
  )

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
 end
end
