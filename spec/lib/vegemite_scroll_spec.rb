require 'vegemite_scroll'

    describe 'VegemiteScroll' do
        let(:product_packs) { VegemiteScroll.packs }

        it 'expects product code must match' do
            expect(VegemiteScroll.code).to eq('VS5')
        end

        it 'expects product packs to be Array' do
            expect(product_packs).to be_instance_of(Array)
        end

        it 'expects to define product packs' do
            expect(product_packs).not_to be_empty
            expect(product_packs[0]).to include(:pack, :price)
        end
    end
