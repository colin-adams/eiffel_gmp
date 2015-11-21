note
	description: "Math functions on MPFs."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPF_MATH

feature -- Power

	pow (v: GMP_FLOAT; power, prec: NATURAL_32): GMP_FLOAT
			-- Raise `v' to the power `power'.
		do
			create Result.make_precision (prec)
			{MPF_FUNCTIONS}.mpf_pow_ui (Result.item, v.item, power)
		ensure
			precision_set: Result.precision >= prec
		end

feature -- Root extraction

	sqrt (v: GMP_FLOAT; prec: NATURAL_32): GMP_FLOAT
			-- Square root of `v'.
		do
			create Result.make_precision (prec)
			{MPF_FUNCTIONS}.mpf_sqrt (Result.item, v.item)
		ensure
			precision_set: Result.precision >= prec
		end

end
