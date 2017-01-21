#!/usr/bin/env ruby

if defined?(::Rails) && Rails.env

  Pry.config.color = true

  if defined?(PryByebug)
    Pry.commands.alias_command 'ss', 'step'
    Pry.commands.alias_command 'nn', 'next'
    Pry.commands.alias_command 'cc', 'continue'
    Pry.commands.alias_command 'fin', 'finish'
    Pry.commands.alias_command 'uu', 'up'
    Pry.commands.alias_command 'dd', 'down'
    Pry.commands.alias_command 'ff', 'frame'
    Pry.commands.alias_command 'bb', 'break'
    Pry.commands.alias_command 'ww', 'whereami'
  end

  GEM_DEPENDENCIES = [
    {
      name: 'factory_girl',
      include: 'FactoryGirl::Syntax::Methods',
      load: 'FactoryGirl.find_definitions'
    },
    {
      name: 'awesome_print',
      include: nil,
      load: 'AwesomePrint.pry!'
    }
  ]

  begin
    GEM_DEPENDENCIES.each do |gem|
      require "#{gem[:name]}"
      include Object.const_get("#{gem[:include]}") if gem[:include]
      gem[:load]
    end
  rescue LoadError => e
    puts "Missing dependency: #{e}"
  end

  # Helpers

  module PryHelpers
    def quick_array
      (1..10).to_a
    end

    def quick_hash
      {
        foo: :bar,
        bar: :foo,
        hello: 'world'
      }
    end
  end

  include PryHelpers

  def pry_help
    puts "-- PryHelpers#instance_methods --"
    PryHelpers.instance_methods.each do |m|
      puts "method: #{m}"
      puts "output: `#{PryHelpers.send(m)}`"
      puts
    end
    puts
  end

  puts "loaded ~/.pryrc"
  puts "dependencies: #{GEM_DEPENDENCIES.map { |g| g[:name] }.join(' | ')}"
  puts "call `pry_help` to see helper methods and aliases"
  puts
end
