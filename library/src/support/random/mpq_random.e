note
	description: "COUNTABLE_SEQUENCE representing random numbers as GMP_RATIONALs."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPQ_RANDOM

inherit
	COUNTABLE_SEQUENCE [GMP_RATIONAL]

create
	make

feature {NONE} -- Initialization

	make (n, d: NATURAL_32)
			-- Initialization for current.
			-- Numbers will be generated with a numerator in the range in the range 0 to 2^`n' - 1, inclusive.
			-- Numbers will be generated with a denominator in the range in the range 0 to 2^`n' - 1, inclusive.
		require
			n_positive: n > n.zero
			d_positive: d > d.zero
		do
			create last_i_th_numerator
			create last_i_th_denominator
			create state
			maximum_value_numerator := n
			maximum_value_denominator := d
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
					{MPZ_FUNCTIONS}.mpz_urandomb (last_i_th_numerator.item, state.item, maximum_value_numerator.item)
					{MPZ_FUNCTIONS}.mpz_urandomb (last_i_th_denominator.item, state.item, maximum_value_denominator.item)
					j := j + 1
				end
				last_i := j
			elseif i > last_i then
				from
					j := last_i
				until
					j = i
				loop
					{MPZ_FUNCTIONS}.mpz_urandomb (last_i_th_numerator.item, state.item, maximum_value_numerator.item)
					{MPZ_FUNCTIONS}.mpz_urandomb (last_i_th_denominator.item, state.item, maximum_value_denominator.item)
					j := j + 1
				end
				last_i := j
			end
			create Result
			Result.set_numerator (last_i_th_numerator.to_gmp_integer)
			Result.set_denominator (last_i_th_denominator.to_gmp_integer)
		end

feature -- Measurement

	maximum_value_numerator: NATURAL_32
			-- 2^`maximum_value_numerator'-1 will be the largest number generated for the numerator of `i_th'.

	maximum_value_denominator: NATURAL_32
			-- 2^`maximum_value_numerator'-1 will be the largest number generated for the denominator of `i_th'.

feature -- Element change

	set_seed (v: GMP_RATIONAL)
			-- Set the seed value from `v'.
		do
			state.set_seed (v.to_gmp_integer)
		end

	set_seed_natural_32 (v: NATURAL_32)
			-- Set the seed value from `v'.
		do
			state.set_seed_natural_32 (v)
		end

feature {NONE} -- Implementation

	last_i: INTEGER_32
		-- Last argument `i' from call to `i_th'.

	last_i_th_numerator: like item
		-- Numerator of the last result of call to `i_th'.

	last_i_th_denominator: like item
		-- Denominator of the last result of call to `i_th'.

	state: RANDOM_STATE
			-- Current state.

end
