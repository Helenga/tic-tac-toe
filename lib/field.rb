class Field
	
	def self.empty_field
		array = []
		for c in 0..3
			array[c] = []
			for r in 0..3
				if (c == 0) ^ ( r == 0 )
				  c == 0 ? array[c][r] = r : array[c][r] = c
				else
				  array[c][r] = ' '
				end
			end
		end
		array
	end
	
	def self.build_field(field)
		for i in 0..3
			puts "_#{field[i].join('_|_')}_"
		end
	end
	
end
