require 'language'
require 'order'

class Bakery

    def self.run

        order = Order.new

        self.print_out(ORDER_HEADER)
        self.print_out(ORDER_EXAMPLE)
        self.print_out(ORDER_COMPLETE)

        input = ''
        until input == 'done' do
            begin
                input = gets().chomp()
                if !order.has_been_recorded?(input) && input != 'done'
                    raise
                end

            rescue Exception => e
                self.print_out(ORDER_FORMAT_ERROR)
                self.print_out(ORDER_EXAMPLE)
                retry
            else
                if input == 'done'
                    self.print_out('----')
                    self.print_out(THANK_YOU_MESSAGE)
                    puts order.fulfill_order
                else
                    self.print_out(CONTINUE)
                end
            end
        end

    end


    def self.print_out(message)
        puts message
    end

end