def outsource
	@something = 7
	class << self
		attr_reader :something
	end
end
class C
	outsource
	self.something
end

p C.something
