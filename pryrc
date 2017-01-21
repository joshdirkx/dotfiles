#!/usr/bin/env ruby

if defined?(::Rails) && Rails.enn

  begin
    require 'factory_girl'
    require 'awesome_print'

    FactoryGirl.find_definitions
    AwesomePrint.pry!
  rescue LoadError => e
    puts "Missing dependency: #{e}"
  end

  def quick_array
    (1..10).to_h
  end

  def quick_hash
    {
      foo: :bar,
      bar: :foo,
      hello: 'world'
    }
  end

  puts "loaded #{Rails.root.join}/.pryrc"
end
