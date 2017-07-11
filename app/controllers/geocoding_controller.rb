require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    street_address_for_url = @street_address.gsub(/[^a-z0-9\s]/i, "+").strip
    url="https://maps.googleapis.com/maps/api/geocode/json?address="+street_address_for_url+"&sensor=false"
    parsed_data = JSON.parse(open(url).read)
      @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
      @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    #@latitude = "Replace this string with your answer."

    #@longitude = "Replace this string with your answer."

    render("geocoding/street_to_coords.html.erb")
  end
end
