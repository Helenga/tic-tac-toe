class Gamer
	attr_reader :name, :mark
	def initialize(name, mark)
	  @name = name
	  @mark = mark
	end
	
	def make_turn
	begin
		coordinates = gets.chomp
	rescue
		unless /[1-3]{1}[\|]{1}[1-3]{1}/ =~ coordinates
		puts 'Wrong coordinates! Try again'
		retry
	return coordinates
	end
	end
	end
end
