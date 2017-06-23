require 'inventory'

class BlueberryMuffin < Inventory


    def self.packs
        [
            { :pack => 2, :price => 9.95 },
            { :pack => 5, :price => 16.95 },
            { :pack => 8, :price => 24.95 }
        ]
    end

    def self.code
        'MB11'
    end

end