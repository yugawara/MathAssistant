#!/usr/bin/env ruby1.9.1

# 2011 Hot Summer in Yugawara Baby
# Yasuaki Kudo



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
	def visual 
		'(' + @counter.to_s + ' ' + @arg.visual+')'
	end
end
class BinaryWff < Wff
	attr_accessor :arg1,:arg2
	class << self
		attr_reader :designation
		attr_reader :visual_designation
	end
	def initialize wff1, wff2
		@arg1,@arg2 = wff1,wff2
		super()
	end
	def who_am_i
		'('+self.class.designation.to_s + @counter.to_s + ' ' + @arg1.who_am_i+ ',' + @arg2.who_am_i+ ')'
	end
	def visual 
		'('+self.class.visual_designation + @counter.to_s + ' ' + @arg1.visual+ ',' + @arg2.visual+ ')'
	end
end
class ConjunctionWff < BinaryWff
	@designation=:c
	@visual_designation='論理積'
end
class DisjunctionWff < BinaryWff
	@designation=:d
	@visual_designation='論理和'
end
class ImplicationWff < BinaryWff
	@designation=:i
	@visual_designation='含意'
end

class AtomicWff < Wff
	def who_am_i
		'p' + @counter.to_s
	end
	def visual 
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
def hello6
	ImplicationWff.new(
		AtomicWff.new,
		DisjunctionWff.new(
			AtomicWff.new,
			AtomicWff.new
			)
		)
end
h = hello6
p h.who_am_i
puts h.visual

