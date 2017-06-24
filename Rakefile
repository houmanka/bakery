task :default => [:run]

desc 'Runs the Bakery Application'
task 'run' do
    $LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
    require 'bakery'

    Bakery.run
end