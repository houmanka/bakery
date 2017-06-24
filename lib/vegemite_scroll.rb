# @author: Houman Kargaran - 2017
# Defining Object

class VegemiteScroll

    # Defining an array of hashes to define the content of this product
    #
    # @param
    # @return [Array<Hash>] product details

    def self.packs
        [
            { :pack => 3, :price => 6.99 },
            { :pack => 5, :price => 8.99 }
        ]
    end

    # Defining the code for each product entry
    #
    # @param
    # @return [String] product code

    def self.code
        'VS5'
     end

end