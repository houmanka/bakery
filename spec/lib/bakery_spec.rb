require 'bakery'

describe Bakery do

  context 'Bakery' do

    it 'expects to be available' do
      expect(Bakery.new).to be_instance_of(Bakery)
    end

      context 'Inventory' do
        it 'expects to have a Hash of Inventory' do
          bakery = Bakery.new
          expect(bakery.instance_variable_get(:@inventory)).to be_instance_of(Array)
        end
      end



  end



end
