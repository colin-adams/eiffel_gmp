note
	description: "COUNTABLE_SEQUENCE representing prime numbers as MPZs."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPZ_PRIMES

inherit
	COUNTABLE_SEQUENCE [GMP_INTEGER]
		redefine
			default_create,
			start
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'.
		do
			create last_i_th
			create state
		end

feature -- Access

	i_th (i: INTEGER_32): like item
			-- The `i'-th random number
		local
			j: INTEGER_32
		do
			if i < last_i then
				start
				from
					j := 1
				until
					j = i
				loop
					{MPZ_FUNCTIONS}.mpz_nextprime (last_i_th.item, last_i_th.item)
					j := j + 1
				end
				last_i := j
			elseif i > last_i then
				from
					j := last_i
				until
					j = i
				loop
					{MPZ_FUNCTIONS}.mpz_nextprime (last_i_th.item, last_i_th.item)
					j := j + 1
				end
				last_i := j
			end
			create Result
			Result.copy (last_i_th)
		end

	lowest_prime: like item
			-- Lowest possible prime.
		do
			create Result.make_integer_32 (2)
		end

feature -- Cursor movement

	start
			-- Move to first position.
		do
			index := 1
			last_i := 1
			last_i_th := lowest_prime
		end

feature {NONE} -- Implementation

	last_i: INTEGER_32
		-- Last argument `i' from call to `i_th'.

	last_i_th: attached like item
		-- Last result of call to `i_th'.

	state: RANDOM_STATE
			-- Current state.

end
