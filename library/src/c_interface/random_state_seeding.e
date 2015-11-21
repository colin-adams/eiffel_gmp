note
	description: "Summary description for {RANDOM_STATE_SEEDING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_STATE_SEEDING

feature -- Access

	gmp_randseed (state, seed: POINTER)
			-- Set an initial `seed' value into `state'.
			-- The size of a seed determines how many different sequences of random numbers that it's possible to generate.
			-- The "quality" of the seed is the randomness of a given seed compared to the previous seed used, and this affects
			-- the randomness of separate number sequences.
			-- The method for choosing a seed is critical if the generated numbers are to be used for important applications,
			-- such as generating cryptographic keys.
			-- Traditionally the system time has been used to seed, but care needs to be taken with this.
			-- If an application seeds often and the resolution of the system clock is low, then the same sequence of numbers might be repeated.
			-- Also, the system time is quite easy to guess, so if unpredictability is required then it should definitely not be the only source
			-- for the seed value.
			-- On some systems there's a special device /dev/random which provides random data better suited for use as a seed.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randseed((__gmp_randstate_struct *)$state, (mpz_srcptr)$seed);
			]"
		end

	gmp_randseed_ui (state: POINTER; seed: NATURAL_32)
			-- Set an initial `seed' value into `state'.
			-- The size of a seed determines how many different sequences of random numbers that it's possible to generate.
			-- The "quality" of the seed is the randomness of a given seed compared to the previous seed used, and this affects
			-- the randomness of separate number sequences.
			-- The method for choosing a seed is critical if the generated numbers are to be used for important applications,
			-- such as generating cryptographic keys.
			-- Traditionally the system time has been used to seed, but care needs to be taken with this.
			-- If an application seeds often and the resolution of the system clock is low, then the same sequence of numbers might be repeated.
			-- Also, the system time is quite easy to guess, so if unpredictability is required then it should definitely not be the only source
			-- for the seed value.
			-- On some systems there's a special device /dev/random which provides random data better suited for use as a seed.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				gmp_randseed((__gmp_randstate_struct *)$state, (unsigned long int)$seed);
			]"
		end

end
