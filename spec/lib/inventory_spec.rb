require 'inventory'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'

describe Inventory do
    describe 'Inventory' do

        let(:inventory) {
            Inventory
        }

        let(:code){
            'MB11'
        }

        let(:wrong_code) {
            ['ABC', nil, '']
        }

        let(:blueberry_muffin) {
            [
                {:pack=>2, :price=>9.95},
                {:pack=>5, :price=>16.95},
                {:pack=>8, :price=>24.95},
                {:code=>"MB11"}
            ]
        }

        it 'expects to return all of the classes' do
            expect( Inventory.define_inventory ).to contain_exactly(BlueberryMuffin, VegemiteScroll, Croissant )
        end


        it 'expects to return code and pack in correct structure' do
            expect(inventory.fetch_an_item(code)).to match_array(blueberry_muffin)
        end

        it 'expects to return empty array if code is not available' do
            wrong_code.each do |code|
                expect(inventory.fetch_an_item(code).size == 0).to be_truthy
            end
        end



    end



end
