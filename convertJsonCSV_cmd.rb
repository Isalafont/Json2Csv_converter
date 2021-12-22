require_relative 'lib/convertJsonCSV'

# Create programme to launch lib converter from CLI using name of ruby file only

if __FILE__ == $0

  # Method take 2 cmd line ARGV (input_file, output_file)
  # Raise exception if there is not 2 arguments
  
  if ARGV.size != 2
    raise('Wrong args : ruby convertJsonCSV_cmd.rb input.json output.csv')
  end

  convert = ConvertJsonCSV.new('./data_input/badges.json', './data_output/badges.csv')
  convert.create_csv(ARGV[0], ARGV[1])
end

# Create cmd line argument : ARGV[0], ARGV[1] to replace input_file/output_file
# => Running ruby convertJsonCSV_cmd.rb file.json file.csv

# TODO find a way to only have to run cmd ruby convertJsonCSV_cmd.rb
