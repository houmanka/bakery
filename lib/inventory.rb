class Inventory

    # FIXME: this is anti pattern to lazy loading.
    def initialize
        @klass_array = []
    end

    def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
    end



    def fetch_an_item(code)

        # find the item code
        klasses = Inventory.descendants

        packs = []
        klasses.each do |klass|
            if klass.code == code
                packs.push klass.packs
                packs.push [ {:code => code } ]
                break
            end
        end

        return packs.flatten


    end




end