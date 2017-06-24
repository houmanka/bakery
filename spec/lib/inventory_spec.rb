require 'inventory'
require 'support/let_singleton'

describe Inventory do

    let (:singleton) {
        LetSingleton.instance
    }

    it 'expects to return all of the classes' do
        expect( Inventory.define_inventory ).to match_array(singleton.class_array)
    end


    it 'expects to return code and pack in correct structure' do
        expect(Inventory.fetch_an_item(singleton.sample_orders[:code])).to match_array(singleton.sample_product)
    end

    it 'expects to return empty array if code is not available' do
        singleton.sample_orders[:invalid_orders].each do |code|
            expect(Inventory.fetch_an_item(code).size == 0).to be_truthy
        end
    end

end