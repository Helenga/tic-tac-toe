class ComputerGamer < Gamer
	# Override make_turn with possibility to inject marks in empty boxes
/	def make_turn
		coordinates = Random.rand(1..3)
	end
	/
end
