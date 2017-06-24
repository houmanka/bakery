# Author: Houman Kargaran
# Defining Object
class BlueberryMuffin

    # defining the pack for each product entry
    def self.packs
        [
            { :pack => 2, :price => 9.95 },
            { :pack => 5, :price => 16.95 },
            { :pack => 8, :price => 24.95 }
        ]
    end

    # defining the code for each product entry
    def self.code
        'MB11'
    end

end