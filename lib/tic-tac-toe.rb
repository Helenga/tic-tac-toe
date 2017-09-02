class TicTacToe

require_relative 'field'
require_relative 'gamer'
require_relative 'computer_gamer'

@@should_enter = "Enter numbers like row|column. For example: 1|3.\nDon`t try to use already filled boxes!"

class << self
def start
	puts 'Welcom!'
#	puts 'Would you like to play with a computer? (yes|no)'
#	@@answer = gets.chomp
	@@answer = 'no'
	create
	puts 'Let`s start'
	now_is_turn_of
end

def create
	@@first_gamer = create_gamer('X')
	if @@answer == 'yes'
		@@second_gamer = ComputerGamer.new('Computer', 'O')
	elsif @@answer == 'no'
		@@second_gamer = create_gamer('O')
	end
	@@field = Field.empty_field
end

def create_gamer(mark)			# In module
	puts 'Enter your name :)'
	name = gets.chomp
	gamer = Gamer.new(name, mark)
	puts "Gamer with name #{name} created. #{name}, your mark is #{mark}"
	gamer
end

def now_is_turn_of
	loop do
		for i in 0..1
			i == 0 ? gamer = @@first_gamer : gamer = @@second_gamer
			puts "Turn of #{gamer.name}"
			puts @@should_enter
			Field.build_field(@@field)
			print 'Put it hear >>'
			coordinates = gamer.make_turn
			change_field(coordinates, gamer.mark)
			Field.build_field(@@field)
			if game_finished?(gamer.mark)
				puts "Congrats! #{gamer.name} is won ^_^"
				exit
			end
		end
	end
end

def change_field(coordinates, mark)				# In module
	coords = change_coordinates(coordinates)
	@@field[coords[0]][coords[1]] = mark
end

def change_coordinates(coordinates)				# In module
	coordinates.split('|').map!{ |c| c.to_i }
end

def game_finished?(mark)
	@@indexes = get_indexes_of_mark(mark)
	@@indexes_of_field = (0..@@marks_field.size - 1).to_a.join
	@@field_width = Math.sqrt(@@marks_field.size).to_i
	gorizontal || vertical || left_slash || right_slash
end

# Write conditions of finishing game

def get_indexes_of_mark(mark)
	@@marks_field = Marshal.load(Marshal.dump(@@field))
	@@marks_field.shift
	@@marks_field.collect{ |r| r.shift }
	@@marks_field = @@marks_field.flatten
	
	indexes_mark = []
	@@marks_field.each_index { |i| indexes_mark.push(i) if @@marks_field[i] == mark }
	indexes_mark = indexes_mark.join
end

def gorizontal
	i = 0
	next_i = @@field_width - 1
	while next_i < @@indexes_of_field.size
		return true if @@indexes == @@indexes_of_field[i..next_i] 
		i = next_i.next
		next_i = i + @@field_width - 1
	end
end

def vertical
	i = 0
	k = 0
	next_i = @@field_width
	while i < @@field_width
		while k < @@field_width
			array = @@indexes_of_field[i]
			array += @@indexes_of_field[next_i]
			next_i += @@field_width
			k += 1
			return true if array == @@indexes
		end
		i += 1
 	end
end

def right_slash
	array = @@indexes_of_field[0]
	next_i = @@field_width + 1
	while next_i < @@indexes_of_field.size
		array += @@indexes_of_field[next_i]
		next_i *= 2
	end
	return true if array == @@indexes
end

def left_slash
	i = @@field_width - 1
	next_i = i
	array = ''
	while next_i < @@indexes_of_field.size - @@field_width
		array += @@indexes_of_field[next_i]
		next_i += i
	end 
	return true if array == @@indexes
end

end

end

TicTacToe.start
