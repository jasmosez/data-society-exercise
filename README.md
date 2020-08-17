

## Instructions for Data Society Programming Exercise for Software Engineer Candidates

Given a list of three geographic US lat / long values in a text file, in this format (you should manually put these three lines into the text file with a text editor):

38.2527° N, 85.7585° W

42.3601° N, 71.0589° W

39.1031° N, 84.5120° W

Write a program that:
* Uses this free weather service to get weather data about each location: https://www.weather.gov/documentation/services-web-api
* Extract the "temperature" value for "Wednesday Night" for each location
* Writes out the results to a local text file, in this format:
 * 72, 68, 70

## Solution Notes

* Exercise completed in get_weather.rb
* Input text contained in coordinates.txt
* Output sent to output.txt
