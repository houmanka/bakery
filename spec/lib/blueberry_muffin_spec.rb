require 'blueberry_muffin'

describe BlueberryMuffin do
    let(:obj) { BlueberryMuffin }
    let(:expected_code) { 'MB11' }

    it 'expects obj code to match to the expectation' do
         expect(obj.code).to eq(expected_code)
    end

    it 'expects obj packs to be Array' do
        expect(obj.packs).to be_instance_of(Array)
    end

    it 'expects to define obj packs' do
        obj.packs[0].keys
        expect(obj.packs).to satisfy{
            |v| v[0].keys.include?(:pack)
        }
    end
end
