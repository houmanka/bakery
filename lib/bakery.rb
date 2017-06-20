# require 'shiny_and_mysterious_gem'
class Bakery

  def initialize

    @inventory = [
        {
            :item => 'VS5',
            :packs => [
                [ 3, '$6.99' ],
                [ 5, '$8.99' ]
            ]
        },
        {
            :item => 'MB11',
            :packs => [
                [ 2, '$9.95'  ],
                [ 5, '$16.95' ],
                [ 8, '$24.95' ]
            ]
        },
        {
            :item => 'CF',
            :packs => [
                [ 3, '$5.95' ],
                [ 5, '$9.95' ],
                [ 9, '$16.99']
            ]
        }
    ]

  end

end