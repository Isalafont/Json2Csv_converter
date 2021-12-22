require_relative 'lib/convertJsonCSV'
require_relative 'lib/load_data'

# Create programme to launch lib converter from CLI using name of ruby file only

if __FILE__ == $0
  
  # if ARGV.size != 2
  #   raise('Wrong args : ruby convertJsonCSV_cmd.rb input.json output.csv')
  # end

  input = LoadData.new('users.json')
  # input.load_data(input_file)
  convert = ConvertJsonCSV.new(input, 'users1.csv')
  # convert.create_csv(ARGV[0], ARGV[1])
  convert.create_csv('users.json', 'users1.csv')
end

# TODO BUG TO FIX

# convert.create_csv(ARGV[0], ARGV[1])
# =>  convertJsonCSV.rb:33:in `read': Is a directory @ io_fread - ./data_input/ (Errno::EISDIR)

# Problem
# If cmd line argument : ARGV[0], ARGV[1] to replace input_file/output_file does not work
# Couldn't pick any files from directory but had to called them.
