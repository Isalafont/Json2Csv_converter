Json2Csv 
The goal of this test is to write a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a CSV file where one line equals one object.

Guide json_to_csv.rb is the module were is implemented the method allowing to format a json file to a new csv file.
The tests are located in json_to_csv.test.rb and can be launched simply by ruby json_to_csv.test.rb. 
This will create the converted file in "output_csv_files" repository and then assert some basic tests to ensure the content created is valid and that basic errors are handled.
```ruby 


require "json"

require "csv"

require "set"

  
  

# file = File.open '/Users/IsabelleL/code/Isalafont/json2csv_converter/input_json_files/users.json'

# data_hash = JSON.load file

# headings = Set.new

# headings = headings.to_a

# data = Hash[*data_hash] # hash class

  

# data.each do |hash|

# headings.merge(get_recursive_keys(hash))

# end

  
  

def get_recursive_keys(hash, nested_key=nil)

hash.each_with_object([]) do |(key,value),keys|

key = "#{nested_key}.#{key}" unless nested_key.nil?

if value.is_a? Hash

keys.concat(get_recursive_keys(value, key))

else

keys << key

end

end

end

end

  

json = JSON.parse(File.open('./input_json_files/users.json').read)

headings = Set.new

headings = headings.to_a

json.each do |hash|

headings.merge(get_recursive_keys(hash))

end

  

CSV.open('./output_json_files/users1.csv', 'w') do |csv|

csv << headings

json.each do |hash|

row = headings.map do |h|

value = hash.dig(*h) # Dig out the (possibly) nested value

if value.is_a?(Array)

value.join(',')

else

value

end# Fix up arrays

end

csv << row

end

csv << row.values

end

end

  
  

CSV.open('/Users/IsabelleL/code/Isalafont/json2csv_converter/output_csv_files/users.csv', 'w') do |csv|

````

```ruby
require 'csv'

require 'json'

require 'set'

  

def get_recursive_keys(hash, nested_key=nil)

hash.each_with_object([]) do |(k,v),keys|

k = "#{nested_key}.#{k}" unless nested_key.nil?

if v.is_a? Hash

keys.concat(get_recursive_keys(v, k))

else

keys << k

end

end

end

  

json = JSON.parse(File.open("./input_json_files/users.json").read)

headings = Set.new

headings = headings.to_a

  

# Iteration on json hash

json.each do |hash|

headings.merge(get_recursive_keys(hash))

end

  

CSV.open('./output_csv_files/file3.csv', 'w') do |csv|

csv << headings

json.each do |hash|

row = {}

headings.each do |heading|

row[heading] = nil

end

hash.each do |k,v|

row[k] = v.to_s.gsub(/\r\n?/, "").delete("\n").delete("\r")

end

csv << row.values

end

end
````
