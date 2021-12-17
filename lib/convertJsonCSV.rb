require 'csv'
require 'json'

module ConvertJsonCSV
 # Working with module allow to call the convert method without instanciate a new class.
 # => ex : ConvertJsonCSV.convert_csv('data/users.json')

 # Recursive method to extract all the keys from the hash to create the CSV header.
 # next / end => if value is a hash, this iteration continue
 
 def flatten_hash_from(hash)
    hash.each_with_object({}) do |(key, value), header|
      next flatten_hash_from(value).each do |k, v|
        header["#{key}.#{k}".intern] = v
      end if value.is_a? Hash
      header[key] = value
    end
  end
  
  #   - input_file : path of the JSON file
  #   - output_file : path of the CSV file
  
  def convert_csv(input_file, output_file)
    # Read the file
    data_hash = JSON.parse(File.open("input_file")).read
    headers = []
    rows = []
    
    # For all objects flatten them
    data_hash.each do |obj|
      row_headers = []
      row = []
      flatten_hash_object(obj, row_headers, row)
      headers << row_headers
      rows << row
    end
    
    CSV.open(output_file, "wb") do |csv|
      csv << headers[0]
      rows.each do |row|
        csv << row
      end
    end
  end
  
end

ConvertJsonCSV.convert_csv('data_input/users.json', 'data_output/users1.csv')
