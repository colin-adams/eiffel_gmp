note

	description: "[
		Iterators across countably infinite sequences indexed by GMP_INTEGER
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

deferred class INFINITE_SEQUENCE_ITERATOR [G]

inherit

	ITERATION_CURSOR [G]

feature -- Access

	item: G
			-- <Precursor>
		deferred
		end

	starting_position: GMP_INTEGER
			-- First position of iteration

	index: GMP_INTEGER
			-- Current position of iteration

	target: INFINITE_SEQUENCE [G]
			-- Sequence being iterated across
		deferred
		end

feature -- Status report

	descending: BOOLEAN
			-- Does `index' decrease as we iterate?

	after: BOOLEAN
			-- Are there no more items to iterate over?


feature -- Cursor movement

	forth
			-- Move to next position.
		deferred
		end

feature {NONE} -- Implementation

	one: GMP_INTEGER
			-- Iteration increment
		once
			create Result.make_integer_32 (1)
		end

invariant

	starting_position_valid: target.valid_index (starting_position)
	index_valid: target.valid_index (index)

end
