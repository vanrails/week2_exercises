# modules is Ruby's way of dealing with multiple inheritence.
# polymorphism

class Animal
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def eat
    "#{name} is eating"
  end

  def speak
    "#{name} is speaking"
  end
end

# in order to use this module, your class must respond to a "name" method call
module Swimmable
  def swim
    "I'm swimming!"
  end
end

module Fetchable
  def fetch
    "#{name} is fetching!"
  end
end

class Mammal < Animal
  include Swimmable

  def warm_blooded?
    true
  end
end

class Dog < Mammal
  include Swimmable
  include Fetchable

  def speak
    "#{name} is barking!"
  end
end

class Cat < Mammal
  def speak
    "#{name} is meowing!"
  end
end

teddy = Dog.new('teddy')
puts teddy.name

kitty = Cat.new('kitty')
puts kitty.name

puts teddy.swim
puts teddy.fetch