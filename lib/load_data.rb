require 'json'

class LoadData
  attr_reader :input_file
  attr_writer :data_json

  FILE_PATH = './data_input'

  def initialize(input_file, data_json)
    @input_file = input_file
    @data_json = data_json
  end

  def load_data(input_file)
    @data_json = JSON.parse(File.open("#{FILE_PATH}/#{@input_file}").read)
  end
  
end
