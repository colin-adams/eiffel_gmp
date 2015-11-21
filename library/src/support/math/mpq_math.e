note
	description: "Summary description for {MPQ_MATH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MPQ_MATH

feature -- Power

	pow (v: GMP_RATIONAL; power: NATURAL_32): GMP_RATIONAL
			-- Raise `v' to the power `power'.
		local
			num, den: GMP_INTEGER
		do
			num := v.numerator
			den := v.denominator
			{MPZ_FUNCTIONS}.mpz_pow_ui (num.item, num.item, power)
			{MPZ_FUNCTIONS}.mpz_pow_ui (den.item, den.item, power)
			create Result
			Result.set_numerator (num)
			Result.set_denominator (den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		end

feature -- Root extraction

	root (v: GMP_RATIONAL; n: NATURAL_32): GMP_RATIONAL
			-- Truncated integer part of the `n'th root of `v'.
		local
			num, den: GMP_INTEGER
			last_root_exact: BOOLEAN
		do
			num := v.numerator
			den := v.denominator
			last_root_exact := {MPZ_FUNCTIONS}.mpz_root (num.item, num.item, n) /= 0
			last_root_exact := {MPZ_FUNCTIONS}.mpz_root (den.item, den.item, n) /= 0
			create Result
			Result.set_numerator (num)
			Result.set_denominator (den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		end

	root_remainder (v: GMP_RATIONAL; n: NATURAL_32): TUPLE [root: GMP_RATIONAL; numerator_remainder, denominator_remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'.
		local
			num_rt, den_rt, num_rem, den_rem: GMP_INTEGER
			rt: GMP_RATIONAL
		do
			num_rt := v.numerator
			den_rt := v.denominator
			create num_rem
			create den_rem
			{MPZ_FUNCTIONS}.mpz_rootrem (num_rt.item, num_rem.item, num_rt.item, n)
			{MPZ_FUNCTIONS}.mpz_rootrem (den_rt.item, den_rem.item, den_rt.item, n)
			create rt
			rt.set_natural (num_rt.to_natural_32)
			rt.set_denominator (den_rt)
			create Result
			Result.root := rt
			Result.numerator_remainder := num_rem
			Result.denominator_remainder := den_rem
		end

	sqrt (v: GMP_RATIONAL): GMP_RATIONAL
			-- Truncated integer part of the square root of `v'.
		local
			num, den: GMP_INTEGER
		do
			num := v.numerator
			den := v.denominator
			{MPZ_FUNCTIONS}.mpz_sqrt (num.item, num.item)
			{MPZ_FUNCTIONS}.mpz_sqrt (den.item, den.item)
			create Result
			Result.set_numerator (num)
			Result.set_denominator (den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		end

	sqrt_remainder (v: attached GMP_RATIONAL; n: NATURAL_32): TUPLE [root: GMP_RATIONAL; numerator_remainder, denominator_remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'.
		local
			num_rt, den_rt, num_rem, den_rem: GMP_INTEGER
			rt: GMP_RATIONAL
		do
			num_rt := v.numerator
			den_rt := v.denominator
			create num_rem
			create den_rem
			{MPZ_FUNCTIONS}.mpz_sqrtrem (num_rt.item, num_rem.item, num_rt.item)
			{MPZ_FUNCTIONS}.mpz_sqrtrem (den_rt.item, den_rem.item, den_rt.item)
			create rt
			rt.set_natural (num_rt.to_natural_32)
			rt.set_denominator (den_rt)
			create Result
			Result.root := rt
			Result.numerator_remainder := num_rem
			Result.denominator_remainder := den_rem
		end

end
