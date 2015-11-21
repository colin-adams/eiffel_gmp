note
	description: "Summary description for {RANDOM_STATE_INITIALIZATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_STATE_INITIALIZATION

feature -- Access

	gmp_randinit_default (state: POINTER)
			-- Initialize `state' with a default algorithm.
			-- This will be a compromise between speed and randomness, and is recommended for applications with no special requirements.
			-- Currently this is `gmp_randinit_mt'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randinit_default((__gmp_randstate_struct *)$state);
			]"
		end

	gmp_randinit_mt (state: POINTER)
			-- Initialize `state' for a Mersenne Twister algorithm.
			-- This algorithm is fast and has good randomness properties.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randinit_mt((__gmp_randstate_struct *)$state);
			]"
		end

	gmp_randinit_lc_2exp (state, a: POINTER; c, m2exp: NATURAL_32)
			-- Initialize `state' with a linear congruential algorithm X = (`a'*X + `c') mod 2^`m2exp'.
			-- The low bits of X in this algorithm are not very random.
			-- The least significant bit will have a period no more than 2, and the second bit no more than 4, etc.
			-- For this reason only the high half of each X is actually used.
			-- When a random number of more than `m2exp'/2 bits is to be generated, multiple iterations of the recurrence
			-- are used and the results concatenated.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randinit_lc_2exp((__gmp_randstate_struct *)$state, (mpz_srcptr)$a, (unsigned long int)$c, (mp_bitcnt_t)$m2exp);
			]"
		end

	gmp_randinit_lc_2exp_size (state: POINTER; size: NATURAL_32): INTEGER_32
			-- Initialize `state' for a linear congruential algorithm as per `gmp_randinit_lc_2exp'.
			-- `a', `c' and `m2exp' are selected from a table, chosen so that size bits (or more) of each X will be used,
			-- ie. `m2exp'/2 >= `size'.
			-- If successful the return value is non-zero.
			-- If size is bigger than the table data provides then the return value is zero.
			-- The maximum size currently supported is 128.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)gmp_randinit_lc_2exp_size((__gmp_randstate_struct *)$state, (mp_bitcnt_t)$size);
			]"
		end

	gmp_randinit_set (rop, op: POINTER)
			-- Initialize `rop' with a copy of the algorithm and state from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randinit_set((__gmp_randstate_struct *)$rop, (__gmp_const __gmp_randstate_struct *)$op);
			]"
		end

	gmp_randclear (state: POINTER)
			-- Free all memory occupied by `state'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randclear((__gmp_randstate_struct *)$state);
			]"
		end

end
