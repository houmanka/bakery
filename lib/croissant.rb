# Author: Houman Kargaran
# Defining Object
class Croissant

    # defining the pack for each product entry
    def self.packs
        [
            { :pack => 3, :price => 5.95 },
            { :pack => 5, :price => 9.95 },
            { :pack => 9, :price => 16.99 }
        ]
    end

    # defining the code for each product entry
    def self.code
        'CF'
    end

end


