require 'blueberry_muffin'

describe BlueberryMuffin do
    describe 'BlueberryMuffin' do
        let(:bb_muffin_packs) { BlueberryMuffin.packs }

        it 'expects BlueberryMuffin code to be MB11' do
            expect(BlueberryMuffin.code).to eq('MB11')
        end

        it 'expects BlueberryMuffin packs to be Array' do
            expect(bb_muffin_packs).to be_instance_of(Array)
        end

        it 'expects to define BlueberryMuffin packs' do
            expect(bb_muffin_packs).not_to be_empty
            expect(bb_muffin_packs[0]).to include(:pack, :price)
        end
    end
end
