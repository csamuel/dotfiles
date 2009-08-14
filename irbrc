#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

IRB.conf[:PROMPT_MODE] = :SIMPLE

IRB.conf[:AUTO_INDENT] = true

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  def megaClone
    begin self.clone; rescue; self; end
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']

class MethodFinder

  def initialize( obj, *args )
      @obj = obj
      @args = args
  end

  def ==( val )
      MethodFinder.show( @obj, val, *@args )    
  end

  # Find all methods on [anObject] which, when called with [args] return [expectedResult]
  def self.find( anObject, expectedResult, *args )
    anObject.methods.select { |name| anObject.method(name).arity == args.size }.
                     select { |name| begin anObject.megaClone.method( name ).call(*args) == expectedResult; 
                                     rescue; end }
  end

  # Pretty-prints the results of the previous method
  def self.show( anObject, expectedResult, *args )
    $old_stderr = $stderr; $stderr = StringIO.new
    methods =
      find( anObject, expectedResult, *args ).each { |name|
        print "#{anObject.inspect}.#{name}" 
        print "(" + args.map { |o| o.inspect }.join(", ") + ")" unless args.empty?
        puts " == #{expectedResult.inspect}" 
      }
    $stderr = $old_stderr
    methods
  end
end

class Object
  def what?(*a)
    MethodFinder.new(self, *a)
  end
end
