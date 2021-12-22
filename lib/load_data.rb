require 'json'

class LoadData
  attr_reader :input_file

  FILE_PATH = './data_input'

  def initialize(input_file)
    @input_file = input_file
    # raise 'Data not found' unless File.exist?(input_file)
  end

  # Case input_file is JSON file
  def load_data(input_file)
    data_json = JSON.parse(File.open("#{FILE_PATH}/#{input_file}").read)
  end
  
end

# FILE PATH DIRECTORY to store into CONSTANT

# OPEN FILE (can be Json, HAML...) and read it
# => File.open("{FILE_PATH}/#{input_file}").read

# def find_file
#   file_list = Dir.children("#{FILE_PATH}")  #=> ["users.json", "new_story.json"]
# end

# TODO 
# Dig into Dir and File doc to select all the files from dir and convert it to csv.
# case json file => JSON.parse
# case not json => File.read 

# Next step once class is working.

