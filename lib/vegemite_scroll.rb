# Author: Houman Kargaran
# Defining Object
class VegemiteScroll

    # defining the pack for each product entry
    def self.packs
        [
                    { :pack => 3, :price => 6.99 },
                    { :pack => 5, :price => 8.99 }
        ]
    end

    # defining the code for each product entry
    def self.code
        'VS5'
     end

end