# @author Houman Kargaran - 2017
# Runner class

require 'language'
require 'order'

class Bakery

    # Accepts input and then react to user response
    #
    # @param
    # @return [String] - STDOUT
    #   sample - Your order please:
    #   sample - Example order: 10 VS5
    #   sample - Type done and enter to calculate.
    #   sample -     10 VS5
    #   sample - Recorded. Enter your new order or done to calculate:
    #   sample -     done
    #   sample - ----
    #   sample - Thank you for your order. Calculating now...
    #   sample - 10 VS5 $17.98
    #   sample -     2 X 5 $8.99
    #   sample - ---------------


    def self.run

        order = Order.new

        self.print_out(ORDER_HEADER)
        self.print_out(ORDER_EXAMPLE)
        self.print_out(ORDER_COMPLETE)

        input = ''
        # until input == DONE do
            begin
                input = gets().chomp()
                if !order.has_been_recorded?(input) && input != DONE
                    raise
                end

            rescue Exception => e
                self.print_out(ORDER_FORMAT_ERROR)
                self.print_out(ORDER_EXAMPLE)
                # retry
            else
                if input == DONE
                    self.print_out('----')
                    self.print_out(THANK_YOU_MESSAGE)
                    puts order.fulfill_order
                else
                    self.print_out(CONTINUE)
                end
            end
        # end

    end


    # printing the message out
    #
    # @param [String]
    # @return [String] - STDOUT

    def self.print_out(message)
        puts message
    end

end