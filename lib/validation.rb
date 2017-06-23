module Validation

    def self.validate(order)
        Validator.run(order)
    end

    class Validator

        def self.run(order)
            return false if order.nil?
            @order = order.split(' ')
            is_correctly_formatted? && is_valid_number?
        end

        def self.is_correctly_formatted?
            result = false
            if @order.size == 2
                result = true
            end
            return result
        end

        def self.is_valid_number?
            /^[0-9]+$/ === @order[0].to_s
        end
    end

end