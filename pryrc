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
    AwesomePrint.pry!
  rescue LoadError => e
    puts "Missing dependency: #{e}"
  end

  # Helpers

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

  def factory_syntax
    include FactoryGirl::Syntax::Methods
  end

  def pry_help
    puts "-- helpers --"
    puts "quick_array    |   [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]"
    puts "quick_hash     |   { foo: :bar, bar: :foo, hello: 'world' }"
    puts "factory_syntax |   `include FactoryGirl::Syntax::Methods`"
    ""
  end

  puts "loaded ~/.pryrc"
  puts "call `pry_help` to see helper methods and aliases"
end
