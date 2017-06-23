require 'inventory'
require 'blueberry_muffin'
require 'vegemite_scroll'
require 'croissant'

describe Inventory do
    describe 'Inventory', :focus=>true do

        let(:inventory) {
            Inventory.new
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


        it 'expects Inventory class to exist' do
            expect(inventory).to be_instance_of(Inventory)
        end

        it 'expects to find all of the decendants' do
            items = Inventory.define_inventory
            expect( items ).to contain_exactly(BlueberryMuffin, VegemiteScroll, Croissant )
        end


        it 'expects to return code and pack in an array' do
            expect(inventory.fetch_an_item(code)).to be_instance_of(Array)
            expect(inventory.fetch_an_item(code)).to include(blueberry_muffin[0])
        end

        it 'expects to return empty array if code is not available' do
            wrong_code.each do |code|
                expect(inventory.fetch_an_item(code).size == 0).to be_truthy
            end
        end



    end



end
