def f(size)
	values = []
	var_masks = (0...size).to_a.reverse.map {|i| puts i; 2**i }
	puts var_masks

	0.upto((2**size) - 1) do |cnt_mask|
		puts cnt_mask
		values << var_masks.map { |var_mask|
			shtuff = var_mask.to_s  + ":" + cnt_mask.to_s +
				":" + (var_mask & cnt_mask).to_s
			r = (var_mask & cnt_mask) == var_mask
			puts r.to_s + shtuff 
			}
			puts "end"
	end
	return values
end
