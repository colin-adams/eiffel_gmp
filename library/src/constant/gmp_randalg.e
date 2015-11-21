note
	description: "Summary description for {GMP_RANDALG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GMP_RANDALG

feature -- Access

	Gmp_rand_alg_default: INTEGER_32 = 0
			--

	Gmp_rand_alg_lc: INTEGER_32 = 0
			-- Linear congruential.

feature -- Status report

	is_valid_gmp_randalg_constant (v: INTEGER_32): BOOLEAN
			-- Is `v' a valid GMP_RANDALG constant?
		do
			Result := (v = Gmp_rand_alg_default) or else
					  (v = Gmp_rand_alg_lc)
		end

end
