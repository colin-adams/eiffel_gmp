note

	description: "Math functions on GMP_INTEGERs."

	author: "Chris Saunders; Colin Adams"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class GMP_INTEGER_MATH

feature -- Contract support

	Zero: GMP_INTEGER
			-- Shared zero for assertions
		once
			create Result
		ensure
			zero_attached: attached Result
		end

feature -- Power

	power (v: GMP_INTEGER; a_power: NATURAL_32): GMP_INTEGER
			-- `v' raised to  `a_power'
		require
			v_attached: attached v
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_pow_ui (Result.item, v.item, a_power)
		ensure
			pow_attached: attached Result
		end

feature -- Root extraction

	root (v: GMP_INTEGER; n: NATURAL_32): TUPLE [root: GMP_INTEGER; is_exact: BOOLEAN]
			-- Truncated integer part of the `n'th root of `v';
			-- If Result.is_exact, then there is no truncation
		require
			v_attached: attached v
			v_not_negative: v >= Zero
		local
			l_root: GMP_INTEGER
			l_exact: BOOLEAN
		do
			create l_root
			l_exact := {MPZ_FUNCTIONS}.mpz_root (l_root.item, v.item, n) /= 0
			create Result
			Result.root := l_root
			Result.is_exact := l_exact
		ensure
			root_attached: attached Result
			root_field_attached: attached Result.root
		end

	root_remainder (v: GMP_INTEGER; n: NATURAL_32): TUPLE [root: GMP_INTEGER; remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'
		require
			v_attached: attached v
			v_not_negative: v >= Zero
		local
			l_rt, l_rem: GMP_INTEGER
		do
			create l_rt
			create l_rem
			{MPZ_FUNCTIONS}.mpz_rootrem (l_rt.item, l_rem.item, v.item, n)
			Result := [l_rt, l_rem]
		ensure
			root_remainder_attached: attached Result
			root_field_attached: attached Result.root
			root_remainder_attached: attached Result.remainder
		end

	sqrt (v: GMP_INTEGER): GMP_INTEGER
			-- Truncated integer part of the square root of `v'
		require
			v_attached: attached v
			v_not_negative: v >= Zero
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_sqrt (Result.item, v.item)
		ensure
			sqrt_attached: attached Result
		end

	sqrt_remainder (v: GMP_INTEGER; n: NATURAL_32): TUPLE [root: GMP_INTEGER; remainder: GMP_INTEGER]
			-- Root and remainder of the square root of `v'.
		require
			v_attached: attached v
			v_not_negative: v >= Zero
		local
			l_rt, l_rem: GMP_INTEGER
		do
			create l_rt
			create l_rem
			{MPZ_FUNCTIONS}.mpz_sqrtrem (l_rt.item, l_rem.item, v.item)
			Result := [l_rt, l_rem]
		ensure
			sqrt_remainder_attached: attached Result
			root_field_attached: attached Result.root
			root_remainder_attached: attached Result.remainder
		end

feature -- Number theoretic

	gcd (v1, v2: GMP_INTEGER): GMP_INTEGER
			-- Greatest common divisor of `v1' and `v2'
		require
			v1_attached: attached v1
			v2_attached: attached v2
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_gcd (Result.item, v1.item, v2.item)
		ensure
			gcd_attached: attached Result
		end

	lcm (v1, v2: GMP_INTEGER): GMP_INTEGER
			-- Least common multiple of `v1' and `v2'
		require
			v1_attached: attached v1
			v2_attached: attached v2
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_lcm (Result.item, v1.item, v2.item)
		ensure
			lcm_attached: attached Result
		end

	jacobi (a, b: GMP_INTEGER): INTEGER_32
			-- Jacobi symbol (`a'/`b')
		require
			a_attached: attached a
			b_attached: attached b
			b_odd: b.is_odd
		do
			Result := {MPZ_FUNCTIONS}.mpz_jacobi (a.item, b.item)
		end

	legendre (a, p: GMP_INTEGER): INTEGER_32
			-- Legendre symbol (`a'/`p')
		require
			a_attached: attached a
			p_attached: attached p
			p_odd: p.is_odd
			p_positive: p > Zero
			p_prime: p.is_prime
		do
			Result := {MPZ_FUNCTIONS}.mpz_legendre (a.item, p.item)
		end

	kronecker (a, b: GMP_INTEGER): INTEGER_32
			-- Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a') when `a' odd, or (`a'/2)=0 when a even;
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are 
			-- identical.
		require
			a_attached: attached a
			b_attached: attached b	
		do
			Result := {MPZ_FUNCTIONS}.mpz_kronecker (a.item, b.item)
		end

	removed (v, f: GMP_INTEGER): TUPLE [with_factors_removed: GMP_INTEGER; factors_removed: NATURAL_32]
			-- All occurrences of the factor `f' removed from `v';
			-- `factors_removed' is set to the number of factors removed.
		require
			v_attached: attached v
			f_attached: attached f	
		local
			l_result: GMP_INTEGER
			l_removed: NATURAL_32
		do
			create l_result
			l_removed := {MPZ_FUNCTIONS}.mpz_remove (l_result.item, v.item, f.item)
			Result := [l_result, l_removed]
		ensure
			removed_attached: attached Result
			with_factors_removed_attached: attached Result.with_factors_removed
		end

	factorial (v: NATURAL_32): GMP_INTEGER
			-- Factorial of `v'
		require
			v_attached: attached v
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_fac_ui (Result.item, v)
		ensure
			factorial_attached: attached Result
		end

	binomial_coefficient (n: GMP_INTEGER; k: NATURAL_32): GMP_INTEGER
			-- Binomial coefficient `n' over `k';
			-- Negative values of `n' are supported using the identity bin(-`n',`k') = (-1)^`k' * bin(`n'+`k'-1,`k'),
			-- see Knuth volume 1 section 1.2.6 part G.
		require
			n_attached: attached n	
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_bin_ui (Result.item, n.item, k)
		ensure
			binomial_coefficient_attached: attached Result
		end

	fibonacci (n: NATURAL_32): GMP_INTEGER
			-- `n'-th Fibonacci number.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_fib_ui (Result.item, n)
		ensure
			fibonacci_attached: attached Result
		end

	lucas (n: NATURAL_32): GMP_INTEGER
			-- `n'-th Lucas number.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_lucnum_ui (Result.item, n)
		ensure
			lucas_attached: attached result
		end

end
