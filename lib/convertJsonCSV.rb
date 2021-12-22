require 'json'
require 'csv'
require_relative 'load_data'

class ConvertJsonCSV

  attr_reader :input_file
  attr_accessor :output_file

  FILE_PATH = './data_input'
  FILE_OUTPUT_PATH = './data_output'

  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
  end

  def create_csv
    data_json = []
    headers = []
    rows = []
    # load_data(input_file) # => from Class LoadData error undefined method NoMethodError
    get_data_from_json
    create_header(data_json)
    add_values(data_json, headers)
    save_csv(headers, rows)
  end

  private

  # Class LoadData Should replace this lines => not sure to know how to call it
  def get_data_from_json
    data_json = JSON.parse(File.open("#{FILE_PATH}/#{@input_file}").read)
  end
  # End Class LoadData

  def create_header(data_json)
    headers = []
    data_json.each do |element|
      headers = get_keys(element, headers)
    end
    return headers.uniq
  end

  def get_keys(data_json, headers, parent = nil)
    data_json.each do |key, value|
      row_headers = parent ? "#{parent}.#{key}" : key
      if value.is_a? Hash
        headers = get_keys(value, headers, row_headers)
      else
        headers << row_headers
      end
    end
    return headers
  end

  def add_values(data_json, headers)
    rows = []
    headers.each do |header|
      rows << data_json.dig(*header.split("."))
    end
    return rows
  end

  def save_csv(headers, rows)
    CSV.open("#{FILE_OUTPUT_PATH}/#{@output_file}", "wb") do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end

end

  # PSEUDO CODE

  # def create_header(datum)
  #   headers est un ARRAY
  #   POUR CHAQUE élément de mes datum
  #     headers = récupérer les clefs de mon élément: get_keys(element, headers)
  #   fin POUR CHAQUE

  #   RETOURNER headers SANS DOUBLON ## SANS DOUBLON peut être fait dans l'itération au dessus si on a peur de données trop grandes
  # end

  # => headers = ["id", "email", "tags", "profiles.facebook.id",
  #               "profiles.facebook.picture",
  #               "profiles.twitter.id",
  #               "profiles.twitter.picture"]

  # def get_keys(element, headers, prefixe DEFAULT NUL)
  #   POUR CHAQUE couple (clef, valeur) de element
  #     nom_du_header = prefixe EXISTE? ALORS "#{prefixe}.#{clef}" SINON: clef
  #     SI valeur est un hash
  #       headers = get_keys(valeur, headers, nom_du_header)
  #     SINON
  #       ajouter nom_du_header à headers
  #     fin SI
  #   fin POUR CHAQUE

  #   RETOURNER headers
  # end

  # def add_values(mon_hash)
  #   row est un ARRAY
  #   POUR CHAQUE header
  #     On met dans row mon_hash[header]
  #   fin POUR CHAQUE
  # end

  # TODO Bug To fix
  # => error message no implicit conversion of String into Integer from convertJsonCSV.rb:45:in `dig'
