require 'httparty'
require 'nokogiri'

def get_weeks_from_period(time_period)
	# time_period (string), that maps to a early or late period of a month
	# returns an array of integers that converts the time_period to series
	# of week numbers in a 52-week year.

	# data source:
	# http://www.simplesteps.org/eat-local/state/

	case time_period
	when "Early January"
		return [1, 2]
	when "Late January"
		return [3, 4]
	when "Early February"
		return [5, 6]
	when "Late February"
		return [7, 8]
	when "Early March"
		return [9, 10]
	when "Late March"
		return [11, 12]
	when "Early April"
		return [13, 14]
	when "Late April"
		return [15, 16]
	when "Early May"
		return [17, 18]
	when "Late May"
		return [19, 20]
	when "Early June"
		return [21, 22]
	when "Late June"
		return [23, 24]
	when "Early July"
		return [25, 26]
	when "Late July"
		return [27, 28]
	when "Early August"
		return [29, 30]
	when "Late August"
		return [31, 32]
	when "Early September"
		return [33, 34]
	when "Late September"
		return [35, 36]
	when "Early October"
		return [37, 38]
	when "Late October"
		return [39, 40]
	when "Early November"
		return [41, 42]
	when "Late November"
		return [43, 44]
	when "Early December"
		return [45, 46]
	when "Late December"
		return [47, 48]
	end
end

api_endpoint = 'http://www.simplesteps.org/eat-local/state/'

states = [
	'alabama',
	'texas',
	'illinois'
]

# states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

data = []

for state in states do
	state_string = state.downcase.tr_s(" ", "-")
	url = api_endpoint + state_string
	response = HTTParty.get(url).body
	seasons = Nokogiri::HTML(response).css('div.season')
	
	state_data = {}
	state_data[:state] = state
	state_data[:source_url] = url
	state_data[:seasonal_data] = []

	for season in seasons
		seasonal_data = {}
		seasonal_data[:time_period] = season.css('h3').text
		seasonal_data[:weeks] = get_weeks_from_period(seasonal_data[:time_period])
		seasonal_ingredients = []

		for item in season.css('a')
			seasonal_ingredients << item.text
		end

		seasonal_data[:ingredients] = seasonal_ingredients

		state_data[:seasonal_data] << seasonal_data
	end
	data << state_data
end


# p data

