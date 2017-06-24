# @author Houman Kargaran - 2017
# Singleton class to keep things clean

require "singleton"

class LetSingleton
    include Singleton

    def sample_orders
            {
                valid_orders: ['13 MB11', '13 CF', '5 VS5'],
                invalid_orders: [ '12 M*11', nil, ' ABM', '12 VSff' ],
                invalid_number_format:  ['111', '', nil],
                valid_product_hash: {:qty => '12', :code => 'MB11'},
                order_series: [ '12 MB11', nil, ' ABM', '12 VSff' ],
                code: 'MB11'
            }
    end

    def sample_pack
        [{:pack => 3, :price => 5.95}, {:pack => 5, :price => 9.95}, {:pack => 9, :price => 16.99}, {:code => 'CF'}]
    end

    def all_of_combinations
        [ [2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 8], [2, 2, 5, 5] ]
    end

    def package_combination_feed
        {
            :packs => [8,5,2],
            :qty => 14
        }
    end

    def single_pack
        Order.fetch_from_inventory(sample_orders[:valid_orders].first)
    end

    def sample_order_ready
        {:summery=>{:total=>25.85, :sku_number=>"CF", :qty=>"13"}, :line_items=>[{:qty=>1, :pack=>3, :each_pack=>5.95}, {:qty=>2, :pack=>5, :each_pack=>9.95}]}
    end

    def sample_product
        [
            {:pack=>2, :price=>9.95},
            {:pack=>5, :price=>16.95},
            {:pack=>8, :price=>24.95},
            {:code=>"MB11"}
        ]
    end

    def class_array
        [BlueberryMuffin, VegemiteScroll, Croissant]
    end

end