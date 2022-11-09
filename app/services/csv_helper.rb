
class CsvHelper
  class << self
    def convert_to_products(csv_data)
      products = []
      csv_file = csv_data.read
      CSV.parse(csv_file) do |row|
        name, price, quantity = row
        products << Product.new(name: name, price: price, quantity: quantity)
      end
      products
    end
  end
end