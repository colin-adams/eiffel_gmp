note
	description: "COUNTABLE_SEQUENCE representing factorial numbers as MPZs."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPZ_LUCAS

inherit
	COUNTABLE_SEQUENCE [GMP_INTEGER]
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create

			-- Initialization for current.
			-- Numbers will be generated in the range in the range 0 to `n' - 1, inclusive.
		do
			create last_i_th
		end

feature -- Access

	i_th (i: INTEGER_32): like item
			-- The `i'-th random number
		do
			if i /= last_i then
				{MPZ_FUNCTIONS}.mpz_lucnum_ui (last_i_th.item, i.to_natural_32 - 1)
			end
			create Result
			last_i := i
			Result.copy (last_i_th)
		end

feature {NONE} -- Implementation

	last_i: INTEGER_32
		-- Last argument `i' from call to `i_th'.

	last_i_th: attached like item
		-- Last result of call to `i_th'.

end
