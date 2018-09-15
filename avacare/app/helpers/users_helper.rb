module UsersHelper


  def closest_doctor(lng, lat, doctors)
    c = 0
    lng = lng.to_i
    lat = lat.to_i
    min  = (lng - (doctors[0]['geocode']['location']['lng'].to_i)).abs +
    (lat - (doctors[0]['geocode']['location']['lat'].to_i))
    min_doctor = doctors[0]
    doctors.each do |doctor|
      puts "stuck here!"
      c += 1
      distance = (lng - doctor['geocode']['location']['lng'].to_i).abs +
      (lat - doctor['geocode']['location']['lat'].to_i)
      if (distance < min)
        min = distance
        min_doctor = doctor
      end
    end
    doctor
  end

  def doctor_decider(symptoms)

  end

  def doctors_in_type(type)
    uri = URI.parse("https://health.axa.ch/hack/api/care-providers?type=#{type}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = ENV["AXA_KEY"]
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    result =  JSON.parse(response.body)
    result['result']
  end


  def medicine_decider(symptoms)
  end
end
