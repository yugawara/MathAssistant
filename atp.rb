#!/usr/bin/env ruby

# Yasuaki Kudo 
def wff_init
	@static_counter = 0
	attr_reader :counter
	def self.add_to_class_counter
		@static_counter += 1
	end
end
class Wff
	def initialize
		@counter = self.class.add_to_class_counter
	end
		
end
class AtomicWff < Wff
	wff_init
	def who_am_i
		'p' + self.counter.to_s
	end
	def visual 
		name
	end
	def name 
		'p' + self.counter.to_s
	end
	def initialize
		super()
	end
	def atomic_wffs
		[self]
	end

end
class NegationWff  < Wff
	wff_init
	attr_accessor :arg	
	def initialize wff
		@arg = wff	
		super()
	end
	def who_am_i
		'(n' + self.counter.to_s + ' ' + @arg.who_am_i+')'
	end
	def visual 
		'(¬ ' + @arg.visual+')'
	end
	def atomic_wffs
		arg.atomic_wffs
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
		'('+self.class.designation.to_s + self.counter.to_s + ' ' + @arg1.who_am_i+ ',' + @arg2.who_am_i+ ')'
	end
	def visual 
		"(#{@arg1.visual} #{self.class.visual_designation} #{@arg2.visual})"
	end
	def atomic_wffs
		arg1.atomic_wffs + arg2.atomic_wffs
	end
end
class ConjunctionWff < BinaryWff
	wff_init
	@designation=:c
	@visual_designation='∧'
end
class DisjunctionWff < BinaryWff
	wff_init

	@designation=:d
	@visual_designation='∨'
end
class ImplicationWff < BinaryWff
	wff_init

	@designation=:i
	@visual_designation='→'
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
		NegationWff.new(NegationWff.new(ImplicationWff.new(AtomicWff.new,
				ConjunctionWff.new(
					AtomicWff.new,
					AtomicWff.new)
				))),
		DisjunctionWff.new(
			ConjunctionWff.new(
				AtomicWff.new,
				AtomicWff.new),
			AtomicWff.new
			)
		)
end
h = hello6
p h.who_am_i
puts h.visual
list =  h.atomic_wffs.map{|x|x.name}
p list
puts 2 ** list.length
