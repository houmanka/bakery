require 'validation'

    describe Validation do

        let (:valid_number) {
            ['10 ABC', '1 abc']
        }
        let (:invalid_number_format) {
            ['111', '', nil]
        }

        it 'expects validates the inout format' do
            invalid_number_format.each do |number|
                v = Validation.validate(number)
                expect(v).to be_falsy
            end

            valid_number.each do |number|
                v = Validation.validate(number)
                expect(v).to be_truthy
            end

        end



    end
