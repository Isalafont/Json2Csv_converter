require_relative 'lib/convertJsonCSV'
require_relative 'lib/load_data'


  input = LoadData.new('users.json')
  # input.load_data(input_file)
  convert = ConvertJsonCSV.new('users.json', 'users1.csv')
  # convert.create_csv('users.json', 'users4.csv')
  convert.create_csv

