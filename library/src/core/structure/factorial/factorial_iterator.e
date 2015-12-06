note

	description: "[
		Iterators across the factorial numbers
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

class FACTORIAL_ITERATOR

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
			create item
			create previous
			if starting_position ~ starting_position.zero then
				item.set_integer_32 (1)
				previous.set_integer_32 (1)
			elseif starting_position ~ starting_position.one then
				item.set_integer_32 (1)
				previous.set_integer_32 (1)
			else
				{MPZ_FUNCTIONS}.mpz_fac_ui (item.item, index.to_natural_32)
			end
		ensure
			target_aliased: target = a_target
			index_set: index ~ a_starting_position
			starting_position_set: starting_position ~ a_starting_position
		end

feature -- Access

	target: GMP_FACTORIAL
			-- <Precursor>

	item: GMP_INTEGER
			-- <Precursor>

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			index := index + one				
			item := previous * index
			previous := item
		end

feature {NONE} -- Implementation

	previous: GMP_INTEGER
			-- Value at `index' - 1

invariant

	previous_attached: attached previous
	
end
