require_relative 'lib/convertJsonCSV'

  convert = ConvertJsonCSV.new('users.json', 'users1.csv')
  convert.create_csv
