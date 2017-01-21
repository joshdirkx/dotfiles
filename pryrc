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

  begin
    require 'factory_girl'
    require 'awesome_print'

    FactoryGirl.find_definitions
    include FactoryGirl::Syntax::Methods
    AwesomePrint.pry!
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

  puts "loaded #{Rails.root.join}/.pryrc"
  puts "call `pry_help` to see helper methods and aliases"
  puts
end
