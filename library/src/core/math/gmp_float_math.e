note

	description: "Math functions on GMP_FLOATs."

	author: "Chris Saunders, Colin Adams"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class GMP_FLOAT_MATH

feature -- Power

	power (v: GMP_FLOAT; a_power, a_prec: NATURAL_32): GMP_FLOAT
			-- `v' raise to to `a_power' with precision`a_prec'
		require
			v_attached: attached v
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			create Result.make_precision (a_prec)
			{MPF_FUNCTIONS}.mpf_pow_ui (Result.item, v.item, a_power)
		ensure
			power_attached: attached Result
			precision_set: Result.precision >= a_prec
		end

feature -- Root extraction

	sqrt (v: GMP_FLOAT; a_prec: NATURAL_32): GMP_FLOAT
			-- Square root of `v' with precision `a_prec'
		require
			v_attached: attached v
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			create Result.make_precision (a_prec)
			{MPF_FUNCTIONS}.mpf_sqrt (Result.item, v.item)
		ensure
			sqrt_attached: attached Result
			precision_set: Result.precision >= a_prec
		end

end
