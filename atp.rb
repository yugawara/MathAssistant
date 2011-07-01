#!/usr/bin/env ruby
class Wff
	@counter=0
	attr_reader :counter
	class << Wff 
		attr_accessor :counter
	end
	def initialize
		Wff.counter+=1
		@counter=Wff.counter
	end
	def who_am_i
		self.class.name + @counter.to_s
	end
end
class NegationWff <  Wff

	attr_accessor :arg	
	def initialize wff
		@arg = wff	
		super()
	end
	def who_am_i
		'(n' + @counter.to_s + ' ' + @arg.who_am_i+')'
	end
end
class BinaryWff < Wff
	attr_accessor :arg1,:arg2
	class << self
		attr_reader :designation
	end
	def initialize wff1, wff2
		@arg1,@arg2 = wff1,wff2
		super()
	end
	def who_am_i
		'('+self.class.designation.to_s + @counter.to_s + ' ' + @arg1.who_am_i+ ',' + @arg2.who_am_i + ')'
	end
end
class ConjunctionWff < BinaryWff
	@designation=:c
end
class DisjunctionWff < BinaryWff
	@designation=:d
end
class ImplicationWff < BinaryWff
	@designation=:i
end

class AtomicWff < Wff
	def who_am_i
		'p' + @counter.to_s
	end
end
def hello
	p 3.times.map{|x|AtomicWff.new}.map{|x|x.who_am_i}
end
def hello2
	p 3.times.map{|x|NegationWff.new AtomicWff.new}.map{|x|x.who_am_i}
end
def hello4
	p 3.times.map{|x|DisjunctionWff.new(AtomicWff.new, AtomicWff.new)}.map{|x|x.who_am_i}
end
def hello5
	p 3.times.map{|x|ImplicationWff.new(AtomicWff.new, AtomicWff.new)}.map{|x|x.who_am_i}
end
hello5
