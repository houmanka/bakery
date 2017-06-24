# @author: Houman Kargaran - 2017
# Defining Object

class BlueberryMuffin

    # Defining an array of hashes to define the content of this product
    #
    # @param
    # @return [Array<Hash>] product details

    def self.packs
        [
            { :pack => 2, :price => 9.95 },
            { :pack => 5, :price => 16.95 },
            { :pack => 8, :price => 24.95 }
        ]
    end

    # Defining the code for each product entry
    #
    # @param
    # @return [String] product code

    def self.code
        'MB11'
    end

end