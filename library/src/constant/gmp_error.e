note
	description: "Summary description for {GMP_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GMP_ERROR

feature -- Access

	Gmp_error_none: INTEGER_32 = 0
			--

	Gmp_error_unsupported_argument: INTEGER_32 = 1
			--

	Gmp_error_division_by_zero: INTEGER_32 = 2
			--

	Gmp_error_sqrt_of_negative: INTEGER_32 = 4
			--

	Gmp_error_invalid_argument: INTEGER_32 = 8
			--

feature -- Status report

	is_valid_gmp_error_constant (v: INTEGER_32): BOOLEAN
			-- Is `v' a valid GMP_ERROR constant?
		do
			Result := (v = Gmp_error_none) or else
					  (v = Gmp_error_unsupported_argument) or else
					  (v = Gmp_error_division_by_zero) or else
					  (v = Gmp_error_sqrt_of_negative) or else
					  (v = Gmp_error_invalid_argument)
		end

end
