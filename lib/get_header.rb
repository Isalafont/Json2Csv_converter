require_relative 'convertJsonCSV'

class GetHeader
  attr_reader :data_json
  attr_accessor :header, :rows

  def initialize(data_json, headers, rows)
    @data_json = data_json
    @headers = headers
    @rows = rows
  end

  def create_header
    @headers = []
    @data_json.each do |element|
      @headers = get_keys(element, @headers)
    end
    return @headers.uniq
  end

  def get_keys(data_json, headers, parent = nil)
    @data_json.each do |key, value|
      row_headers = parent ? "#{parent}.#{key}" : key
      if value.is_a? Hash
        @headers = get_keys(value, headers, row_headers)
      else
        @headers << row_headers
      end
    end
    return @headers
  end

end