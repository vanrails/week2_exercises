# Week 2 Quiz

###1. Name what each of the below is:
  a = 1 # => ex. a is a local variable, and is a Fixnum object with value 1

  @a = 2 # => @a is an instance variable, a Fixnum object with value 2

  user = User.new # => user is an object of class User.

  user.name # => user.name is an instance method of user, likely a getter method.

  user.name = "Joe" # => user.name is a setter instance method.

###2. How does a class mixin a module?
  A class can mixin a module by adding an include 'NameHere' on the first
  line in its body.

###3. What's the difference between class variables and instance variables?
  A class variable can only be accesessed within a class not from an instance
  of the class like an instance variable.

###4. What does `attr_accessor` do?
  attr_accessor create getter methods, setter methods and the associated
  instance variables.

###5. How would you describe this expression: `Dog.some_method`
  'Dog.some_method' represents a call to the Dog class method some_method

###6. In Ruby, what's the difference between subclassing and mixing in modules?
  Subclassing involves deriving a new class from a base class while mixing
  in a module extends an existing class with properties.

###7. Given that I can instantiate a user like this: `User.new('Bob')`, what would the `initialize` method look like for the `User` class?
  def initialize(name)
    @name = name
  end

###8. Can you call instance methods of the same class from other instance methods in that class?
  Yes

###9. When you get stuck, what's the process you use to try to trap the error?
  To trap an error is to isolate it. So, I start with a hypothesis about the
  location of the infracting code based on the output of the program.
  I then block of segments with increasing narrowness until the output is
  altered. Once I know the precise piece of code that is the cause of
  problems I can begin to alter values/output to understand the error if
  it is not readily apparent.