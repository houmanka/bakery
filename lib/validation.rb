# @author: Houman Kargaran - 2017
# Validation module

module Validation

    # Exposed method to run the validation
    #
    # @param [String]
    # @return [Boolean]

    def self.validate(order)
        Validator.run(order)
    end

    # Internal class module to encapsulate the data
    #
    # @param
    # @return

    class Validator

        # Runner
        #
        # @param [String]
        # @return [Boolean]

        def self.run(order)
            return false if order.nil?
            @order = order.split(' ')
            is_correctly_formatted? && is_valid_number?
        end

        # Checks the formatting
        #
        # @param
        # @return [Boolean]

        def self.is_correctly_formatted?
            result = false
            if @order.size == 2
                result = true
            end
            return result
        end

        # Checks the number formatting
        #
        # @param
        # @return [Boolean]

        def self.is_valid_number?
            /^[0-9]+$/ === @order[0].to_s
        end
    end

end