require 'croissant'
require 'vegemite_scroll'
require 'blueberry_muffin'

class Inventory

    # FIXME: this is anti pattern to lazy loading.
    def initialize
        @klass_array = []
    end

    def self.define_inventory
        [ Croissant, BlueberryMuffin, VegemiteScroll]
    end



    def fetch_an_item(code)

        # find the item code
        klasses = Inventory.define_inventory

        packs = []
        klasses.each do |klass|
            if klass.code.to_s == code.to_s
                packs.push klass.packs
                packs.push [ {:code => code } ]

            end
        end

        return packs.flatten


    end




end