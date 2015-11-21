note
	description: "COUNTABLE_SEQUENCE representing random numbers as MPFs."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPF_RANDOM

inherit
	COUNTABLE_SEQUENCE [GMP_FLOAT]

create
	make

feature {NONE} -- Initialization

	make (v: NATURAL_32)
			-- Initialization for `Current'.
			-- Generates numbers that are in the range [0, 1) with `v' significant bits in the mantissa.
		do
			precision := v
			create last_i_th.make_precision (precision)
			create state
		end

feature -- Access

	i_th (i: INTEGER_32): like item
			-- The `i'-th random number
		local
			j: INTEGER_32
		do
			if i < last_i then
				create state
				from
					j := 0
				until
					j = i
				loop
					{MPF_FUNCTIONS}.mpf_urandomb (last_i_th.item, state.item, precision)
					j := j + 1
				end
				last_i := j
			elseif i > last_i then
				from
					j := last_i
				until
					j = i
				loop
					{MPF_FUNCTIONS}.mpf_urandomb (last_i_th.item, state.item, precision)
					j := j + 1
				end
				last_i := j
			end
			create Result
			Result.copy (last_i_th)
		end

feature -- Measurement

	precision: NATURAL_32
			-- Number of significant bits in the mantissa of the generated number.

feature -- Element change

	set_seed (v: GMP_INTEGER)
			-- Set the seed value from `v'.
		do
			state.set_seed (v)
		end

	set_seed_natural_32 (v: NATURAL_32)
			-- Set the seed value from `v'.
		do
			state.set_seed_natural_32 (v)
		end

feature {NONE} -- Implementation

	last_i: INTEGER_32
		-- Last argument `i' from call to `i_th'.

	last_i_th: like item
		-- Last result of call to `i_th'.

	state: RANDOM_STATE
			-- Current state.

end
