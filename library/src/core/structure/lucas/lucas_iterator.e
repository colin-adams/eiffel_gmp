note

	description: "[
		Iterators across the Lucas sequence
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

class LUCAS_ITERATOR

inherit

	INFINITE_SEQUENCE_ITERATOR [GMP_INTEGER]

create

	make

feature {NONE} -- Initialization

	make (a_target: like target; a_starting_position: GMP_INTEGER)
			-- Set `target' and `index'.
		require
			a_target_attached: attached a_target
			a_starting_position_attached: attached a_starting_position
			a_starting_position_small_enough: a_starting_position.fits_natural_32
		do
			target := a_target
			starting_position := a_starting_position.twin
			index := a_starting_position.twin
			before := True
			create item
			create previous
			if starting_position ~ starting_position.zero then
				previous.set_integer_32 (-1)
				item.set_integer_32 (2)
			elseif starting_position ~ starting_position.one then
				item.set_integer_32 (1)
				previous.set_integer_32 (2)
			else
				{MPZ_FUNCTIONS}.mpz_lucnum2_ui (item.item, previous.item, index.to_natural_32)
			end
			forth
		ensure
			target_aliased: target = a_target
			index_set: index ~ a_starting_position
			starting_position_set: starting_position ~ a_starting_position
		end

feature -- Access

	target: GMP_LUCAS
			-- <Precursor>

	item: GMP_INTEGER
			-- <Precursor>

feature -- Cursor movement

	forth
			-- Move to next position.
		local
			l_item: like item
		do
			if before then
				before := False
			else
				index := index + one
				l_item := item
				item := item + previous
				previous := l_item
			end
		end

feature {NONE} -- Implementation

	before: BOOLEAN
			-- Has `forth' been called yet?

	previous: GMP_INTEGER
			-- L(N-1)
	
end


