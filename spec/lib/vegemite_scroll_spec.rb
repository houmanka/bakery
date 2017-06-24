require 'vegemite_scroll'

    describe 'VegemiteScroll' do
        let(:obj) { VegemiteScroll }
        let(:expected_code) { 'VS5' }

        it 'expects product code must match' do
            expect(obj.code).to eq(expected_code)
        end

        it 'expects product packs to be Array' do
            expect(obj.packs).to be_instance_of(Array)
        end

        it 'expects to define obj packs' do
            puts obj.packs[0].keys
            expect(obj.packs).to satisfy{
                |v| v[0].keys.include?(:pack)
            }
        end
    end
