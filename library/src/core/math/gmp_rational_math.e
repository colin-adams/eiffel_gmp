note

	description: "Math functions on GMP_RATIONALs"

	author: "Chris Saunders, Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

class GMP_RATIONAL_MATH

feature -- Power

	power (v: GMP_RATIONAL; a_power: NATURAL_32): GMP_RATIONAL
			-- `v' raised to `a_power'
		require
			v_attached: attached v
		local
			l_num, l_den: GMP_INTEGER
		do
			l_num := v.numerator
			l_den := v.denominator
			{MPZ_FUNCTIONS}.mpz_pow_ui (l_num.item, l_num.item, a_power)
			{MPZ_FUNCTIONS}.mpz_pow_ui (l_den.item, l_den.item, a_power)
			create Result
			Result.set_numerator (l_num)
			Result.set_denominator (l_den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		ensure
			power_attached: attached Result
		end

feature -- Root extraction

	root (v: GMP_RATIONAL; n: NATURAL_32): GMP_RATIONAL
			-- Truncated integer part of the `n'th root of `v'
		require
			v_attached: attached v
		local
			l_num, l_den: GMP_INTEGER
			l_last_root_exact: BOOLEAN
		do
			l_num := v.numerator
			l_den := v.denominator
			l_last_root_exact := {MPZ_FUNCTIONS}.mpz_root (l_num.item, l_num.item, n) /= 0
			l_last_root_exact := {MPZ_FUNCTIONS}.mpz_root (l_den.item, l_den.item, n) /= 0
			create Result
			Result.set_numerator (l_num)
			Result.set_denominator (l_den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		ensure
			root_attached: attached Result
		end

	root_remainder (v: GMP_RATIONAL; n: NATURAL_32): TUPLE [root: GMP_RATIONAL; numerator_remainder, denominator_remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'
		require
			v_attached: attached v
		local
			l_num_rt, l_den_rt, l_num_rem, l_den_rem: GMP_INTEGER
			l_rt: GMP_RATIONAL
		do
			l_num_rt := v.numerator
			l_den_rt := v.denominator
			create l_num_rem
			create l_den_rem
			{MPZ_FUNCTIONS}.mpz_rootrem (l_num_rt.item, l_num_rem.item, l_num_rt.item, n)
			{MPZ_FUNCTIONS}.mpz_rootrem (l_den_rt.item, l_den_rem.item, l_den_rt.item, n)
			create l_rt
			l_rt.set_natural (l_num_rt.to_natural_32)
			l_rt.set_denominator (l_den_rt)
			create Result
			Result.root := l_rt
			Result.numerator_remainder := l_num_rem
			Result.denominator_remainder := l_den_rem
		ensure
			root_remainder_attached: attached Result
			root_field_attached: attached Result.root
			numerator_remainder_attached: attached Result.numerator_remainder
			denominator_remainder_attached: attached Result.denominator_remainder
		end

	sqrt (v: GMP_RATIONAL): GMP_RATIONAL
			-- Truncated integer part of the square root of `v'
		require
			v_attached: attached v	
		local
			l_num, l_den: GMP_INTEGER
		do
			l_num := v.numerator
			l_den := v.denominator
			{MPZ_FUNCTIONS}.mpz_sqrt (l_num.item, l_num.item)
			{MPZ_FUNCTIONS}.mpz_sqrt (l_den.item, l_den.item)
			create Result
			Result.set_numerator (l_num)
			Result.set_denominator (l_den)
			{MPQ_FUNCTIONS}.mpq_canonicalize (Result.item)
		ensure
			square_attached: attached Result
		end

	sqrt_remainder (v: attached GMP_RATIONAL; n: NATURAL_32): TUPLE [root: GMP_RATIONAL; numerator_remainder, denominator_remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'.
		require
			v_attached: attached v
		local
			l_num_rt, l_den_rt, l_num_rem, l_den_rem: GMP_INTEGER
			l_rt: GMP_RATIONAL
		do
			l_num_rt := v.numerator
			l_den_rt := v.denominator
			create l_num_rem
			create l_den_rem
			{MPZ_FUNCTIONS}.mpz_sqrtrem (l_num_rt.item, l_num_rem.item, l_num_rt.item)
			{MPZ_FUNCTIONS}.mpz_sqrtrem (l_den_rt.item, l_den_rem.item, l_den_rt.item)
			create l_rt
			l_rt.set_natural (l_num_rt.to_natural_32)
			l_rt.set_denominator (l_den_rt)
			create Result
			Result.root := l_rt
			Result.numerator_remainder := l_num_rem
			Result.denominator_remainder := l_den_rem
		ensure
			sqrt_remainder_attached: attached Result
			root_field_attached: attached Result.root
			numerator_remainder_attached: attached Result.numerator_remainder
			denominator_remainder_attached: attached Result.denominator_remainder
		end

end
