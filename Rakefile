require 'puppet-lint'

namespace :test do
  namespace :augeas do
    task :syntax do
      lenses = Dir['files/usr/share/augeas/lenses/*.aug']
      lenses.each do |lens|
        $stdout.write "Syntax checking #{lens}... "
        $stdout.flush
        output = `augparse #{lens} 2>&1`
        if $?.success?
          puts "OK"
        else
          puts "failed"
          puts "---"
          puts output
          fail
        end
      end
    end

    task :tests do
      lenses = Dir['files/usr/share/augeas/lenses/tests/*.aug']
      lenses.each do |lens|
        $stdout.write "Running tests in #{lens}... "
        $stdout.flush
        output = `augparse -I files/usr/share/augeas/lenses #{lens} 2>&1`
        if $?.success?
          puts "OK"
        else
          puts "failed"
          puts "---"
          puts output
          fail
        end
      end
    end
  end
  task :augeas => ['augeas:syntax', 'augeas:tests']

  namespace :puppet do
    task :syntax do
      files = Dir['manifests/**/*.pp']
      files.each do |file|
        $stdout.write "Syntax checking #{file}... "
        $stdout.flush
        output = `bundle exec puppet parser validate #{file} 2>&1`
        if $?.success?
          puts "OK"
        else
          puts "failed"
          puts "---"
          puts output
          fail
        end
      end
    end

    task :lint do
      linter =  PuppetLint.new
      Dir.glob('manifests/**/*.pp').each do |puppet_file|
        puts "Evaluating #{puppet_file}"
        linter.file = puppet_file
        linter.run
      end
      fail if linter.errors?
    end
  end
  task :puppet => ['puppet:syntax', 'puppet:lint']
end

task :test => ['test:augeas', 'test:puppet']
task :default => :test
