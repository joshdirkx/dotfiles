#!/usr/bin/env ruby

if defined?(::Rails) && Rails.env
  load_start = Time.now

  class String
    def red
      "\e[31m#{self}\e[0m"
    end
  end

  module PryHelpers
    class Gem
      attr_accessor :name, :load, :include

      def initialize(options = {})
        options.each { |attr, value| send("#{attr}=", value) }
      end
    end

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

  [
    {
      name: 'factory_girl',
      include: 'FactoryGirl::Syntax::Methods',
      load: 'find_definitions'
    },
    {
      name: 'awesome_print',
      include: nil,
      load: 'pry!'
    }
  ].each do |options|
    PryHelpers::Gem.new(options)
  end

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

  LOADED_GEMS = ObjectSpace.each_object(PryHelpers::Gem)

  begin
    LOADED_GEMS.each do |gem|
      require "#{gem.name}"
      include Object.const_get(gem.include) if gem.include
      Object.const_get(gem.name.camelcase).send(gem.load) if gem.load
    end
  rescue LoadError => err
    puts "Missing dependency: #{err}"
  ensure
    include PryHelpers
  end

  def pry_help
    puts "-- PryHelpers#instance_methods --"
    PryHelpers.instance_methods.each do |method|
      puts "method: #{method}"
      puts "output: `#{PryHelpers.send(method)}`"
      puts
    end
    nil
  end

  puts
  puts "~/.pryrc loaded in " + "#{Time.now - load_start}".red
  puts "dependencies: " + "#{LOADED_GEMS.map(&:name).join(', ')}".red
  puts "call " + "`pry_help`".red + " to see helper methods and aliases"
  puts
end
