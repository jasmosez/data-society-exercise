# EXERCISE INSTRUCTIONS:
# ----------------------
# Uses this free weather service to get weather data about each location:
# https://www.weather.gov/documentation/services-web-api
# Extract the "temperature" value for "Wednesday Night" for each location
# Writes out the results to a local text file, in this format:
# 72, 68, 70


require 'faraday'
require 'json'
require 'byebug'

def get_coords(file)
# import lat/long data, transform contents to format required by Weather API and store each lat/long pair in an array of strings
# return that array of strings

  arr_of_coords = []

  File.open(file).each do |line|
    # remove whitespace and degree char '°' from string and split it on the comma
    line_arr = line.gsub(/[^\d.,-NEWS]+/, "").split(',')

    # transform line_arr to format required by API
    line_arr.map! do |coord|
      # if lat / long is S or W, flip the sign of the numeral
      if coord[-1] == "S" || coord[-1] == "W"
        coord = "-" + coord
      end

      # remove directional indication now that we have it reflected in the sign
      coord.gsub!(/[NEWS]/, "")

      # remove any trailing zeros as required by API
      coord.gsub!(/\.?0+$/, "")
      coord
    end

    # rejoin line_arr into a single string separated by comma and push it into the results array
    arr_of_coords.push(line_arr.join(','))

  end
  
  # return array of strings
  return arr_of_coords
end

def get_temp_for_coord(coord, period_name)
# use a properly formatted coordinate string to get the temperature forecast for a given period
# return the temperature as a string
  
  # Query the API's 'point' endpoint
  url = "https://api.weather.gov/points/#{coord}"
  resp = Faraday.get(url)
  json = JSON.parse(resp.body)
  
  # extract the forecast link and query that
  forecast_url = json["properties"]["forecast"]
  forecast_resp = Faraday.get(forecast_url)
  forecast_json = JSON.parse(forecast_resp.body)

  # Extract forecast hash for period_name
  forecast = forecast_json["properties"]["periods"].find {|p| p["name"] == period_name}
   
  # return temperature
  return forecast["temperature"]
end


# get an array of coordinate strings
coords_arr = get_coords("./coordinates.txt")

# map that to an array of temperature strings -- instructions specify "Wednesday Night" so it is hard coded.
temperatures = coords_arr.map do |coord_str|
  get_temp_for_coord(coord_str, "Wednesday Night")
end

# create an output string from temperatures array
output_string = temperatures.join(', ')

# Write to file
File.open("./output.txt", 'w') do |line|
  line.puts output_string
end