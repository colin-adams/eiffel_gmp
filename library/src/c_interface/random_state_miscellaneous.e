note
	description: "Summary description for {RANDOM_STATE_MISCELLANEOUS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_STATE_MISCELLANEOUS

feature -- Access

	gmp_urandomb_ui (state: POINTER; n: NATURAL_32): NATURAL_32
			-- Return a uniformly distributed random number of `n' bits, ie. in the range 0 to 2^`n'-1 inclusive.
			-- `n' must be less than or equal to the number of bits in an unsigned long.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long)gmp_urandomb_ui((__gmp_randstate_struct *)$state, (unsigned long)$n);
			]"
		end

	gmp_urandomm_ui (state: POINTER; n: NATURAL_32): NATURAL_32
			-- Return a uniformly distributed random number in the range 0 to `n'-1, inclusive.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long)gmp_urandomm_ui((__gmp_randstate_struct *)$state, (unsigned long)$n);
			]"
		end

end
