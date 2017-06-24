require 'bakery'
require 'language'
require 'support/let_singleton'


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

        it "should receive `foobar`" do
            fake_stdin("foobar") do
                input = gets().chomp()
                puts input
            end
        end

     end

end