require 'bakery'
require 'language'
require 'support/let_singleton'

# Note: Need to work on this.
describe Bakery do

    let (:singleton) {
        LetSingleton.instance
    }

    context 'Application' do
        def fake_stdin(*args)
            begin
                $stdin = StringIO.new
                $stdin.puts(args.shift) until args.empty?
                $stdin.rewind
                yield
            ensure
                $stdin = STDIN
            end
        end

        specify { expect { print('10 VS5') }.to output.to_stdout }
        specify {
            Bakery.run
            expect { print('done') }.to output.to_stdout }

        it 'should receive `10 VS5`' do
            fake_stdin('10 VS5') do
                input = gets().chomp()
                expect(input).to eq('10 VS5')
            end
        end
     end

end