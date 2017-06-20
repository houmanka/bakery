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

    context 'Shopper' do
        describe 'shopping behavior' do
            it 'expects to enter her shopping order' do
                pending('Make so it accepts the input from Command line - I need to research this')
                fail
            end

            it 'expects to enter her list line by line' do
                pending('After each line she should be pressing Enter')
                fail
            end

            it 'expects to enter done and process finishes' do
                pending('At the very end he types done.')
                fail
            end

            it 'expects to enter done and see the result' do
                pending('calculation is done and we would see the result')
                fail
            end
        end

        describe 'order items' do
            it 'expects to enter each item in "Number SKUNumber" format' do
                pending('When you chomp it make sure you validate the input')
                fail
            end

            it 'expects the first lot chars before space to be number' do
                pending('When you chomp it make sure you validate the input')
                fail
            end

            it 'expects the quantity to be more than 0' do
                pending('When you chomp it make sure you validate the input')
                fail
            end

            it 'expects the second lot chars after space to be from the inventory' do
                pending('When you chomp it make sure you validate the input')
                fail
            end

            describe 'validation' do
                it 'expects to return logical error for incidences' do
                    pending('All of the validation line in here for later on')
                    fail
                end
            end
        end

        describe 'purchase' do
            it 'expects to determine the cost' do
                pending('Needs thinking too late now')
                fail
            end

            it 'expects to determine the pack breakdown' do
                pending('Needs thinking too late now')
                fail
            end

            it 'expects to determine the pack breakdown' do
                pending('Needs thinking too late now')
                fail
            end

            it 'expects to calculate the minimal number of packs per line of order' do
                pending('Needs thinking too late now')
                fail
            end
        end
    end
end