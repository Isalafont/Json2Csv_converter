require 'json'
require 'csv'

module ConvertJsonCSV
  
  def self.create_csv(input_file, output_file)
    data_json = []
    headers = []
    rows = []
    get_data_from_json(input_file)
    create_header(data_json)
    add_values(data_json, headers)
    save_csv(output_file, headers, rows)
  end

  def self.get_data_from_json(input_file)
    data_json = JSON.parse(File.open(input_file).read)
  end

  def self.create_header(data_json)
    headers = []
    data_json.each do |element|
      headers = get_keys(element, headers)
    end
    return headers.uniq
  end

  # => headers = ["id", "email", "tags", "profiles.facebook.id", 
  #               "profiles.facebook.picture",
  #               "profiles.twitter.id",
  #               "profiles.twitter.picture"]

  def self.get_keys(data_json, headers, parent = nil)
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

  def self.add_values(data_json, headers)
    rows = []
    headers.each do |header|
      rows << data_json.dig(*header.split("."))
    end
    return rows
  end

  # => error message no implicit conversion of String into Integer from convertJsonCSV.rb:45:in `dig'

  def self.save_csv(output_file, headers, rows)
    CSV.open(output_file, "wb") do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end

end

ConvertJsonCSV.create_csv('./data_input/users.json', './data_output/users2.csv')

  # PSEUDO CODE

  # def create_header
  #   headers est un ARRAY
  #   POUR CHAQUE élément de mes données
  #     headers = récupérer les clefs de mon élément: get_keys(element, headers)
  #   fin POUR CHAQUE

  #   RETOURNER headers SANS DOUBLON ## SANS DOUBLON peut être fait dans l'itération au dessus si on a peur de données trop grandes
  # end

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

  # def hash_to_array(mon_hash)
  #   row est un ARRAY
  #   POUR CHAQUE header
  #     On met dans row mon_hash[header]
  #   fin POUR CHAQUE
  # end
