require 'validation'
require 'support/let_singleton'

describe Validation do

    let (:singleton) {
        LetSingleton.instance
    }

    it 'expects validates the inout format' do
        singleton.sample_orders[:invalid_number_format].each do |number|
            v = Validation.validate(number)
            expect(v).to be_falsy
        end

        singleton.sample_orders[:valid_orders].each do |number|
            v = Validation.validate(number)
            expect(v).to be_truthy
        end

    end

end
