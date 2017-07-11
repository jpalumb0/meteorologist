require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    street_address_for_url = @street_address.gsub(/[^a-z0-9\s]/i, "+").strip
    url_google="https://maps.googleapis.com/maps/api/geocode/json?address="+street_address_for_url+"&sensor=false"
    parsed_data_google = JSON.parse(open(url_google).read)
      lat = parsed_data_google["results"][0]["geometry"]["location"]["lat"].to_s
      lng = parsed_data_google["results"][0]["geometry"]["location"]["lng"].to_s


    url_darksky = "https://api.darksky.net/forecast/6ab151a0e8162a50d8261d76dcd238da/"+lat+","+lng
    parsed_data_darksky = JSON.parse(open(url_darksky).read)
      
    @current_temperature = parsed_data_darksky["currently"]["temperature"]

    @current_summary = parsed_data_darksky["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_darksky["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_darksky["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_darksky["daily"]["summary"]
    render("meteorologist/street_to_weather.html.erb")
  end
end
