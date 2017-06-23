require 'croissant'

describe Croissant do
    describe 'Croissant' do
        let(:product_packs) { Croissant.packs }

        it 'expects product code must match' do
            expect(Croissant.code).to eq('CF')
        end

        it 'expects product packs to be Array' do
            expect(product_packs).to be_instance_of(Array)
        end

        it 'expects to define product packs' do
            expect(product_packs).not_to be_empty
            expect(product_packs[0]).to include(:pack, :price)
        end
    end
end
