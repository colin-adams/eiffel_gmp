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
		end

feature -- Power

	pow (v: GMP_INTEGER; power: NATURAL_32): GMP_INTEGER
			-- Raise `v' to the power `power'.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_pow_ui (Result.item, v.item, power)
		end

feature -- Root extraction

	root (v: GMP_INTEGER; n: NATURAL_32): GMP_INTEGER
			-- Truncated integer part of the `n'th root of `v'.
		do
			create Result
			last_root_exact := {MPZ_FUNCTIONS}.mpz_root (Result.item, v.item, n) /= 0
		end

	root_remainder (v: GMP_INTEGER; n: NATURAL_32): TUPLE [root: GMP_INTEGER; remainder: GMP_INTEGER]
			-- Root and remainder of the `n'th root of `v'.
		local
			rt, rem: GMP_INTEGER
		do
			create rt
			create rem
			{MPZ_FUNCTIONS}.mpz_rootrem (rt.item, rem.item, v.item, n)
			create Result
			Result.root := rt
			Result.remainder := rem
		end

	sqrt (v: GMP_INTEGER): GMP_INTEGER
			-- Truncated integer part of the square root of `v'.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_sqrt (Result.item, v.item)
		end

	sqrt_remainder (v: GMP_INTEGER; n: NATURAL_32): TUPLE [root: GMP_INTEGER; remainder: GMP_INTEGER]
			-- Root and remainder of the square root of `v'.
		local
			rt, rem: GMP_INTEGER
		do
			create rt
			create rem
			{MPZ_FUNCTIONS}.mpz_sqrtrem (rt.item, rem.item, v.item)
			create Result
			Result.root := rt
			Result.remainder := rem
		end

feature -- Status report

	factors_removed: NATURAL_32
			-- Number of factors removed by `remove'.

	last_root_exact: BOOLEAN
			-- Was the last root extracted by `root' exact?

feature -- Number theoretic

	gcd (v1, v2: GMP_INTEGER): GMP_INTEGER
			-- Greatest common divisor of `v1' and `v2'.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_gcd (Result.item, v1.item, v2.item)
		end

	lcm (v1, v2: GMP_INTEGER): GMP_INTEGER
			-- Least common multiple of `v1' and `v2'.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_lcm (Result.item, v1.item, v2.item)
		end

	jacobi (a, b: GMP_INTEGER): INTEGER_32
			-- Jacobi symbol (`a'/`b').
		require
			b_odd: b.is_odd
		do
			Result := {MPZ_FUNCTIONS}.mpz_jacobi (a.item, b.item)
		end

	legendre (a, p: GMP_INTEGER): INTEGER_32
			-- Legendre symbol (`a'/`p').
		require
			p_odd: p.is_odd
			p_positive: p > Zero
			p_prime: p.is_prime
		do
			Result := {MPZ_FUNCTIONS}.mpz_legendre (a.item, p.item)
		end

	kronecker (a, b: GMP_INTEGER): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a') when `a' odd, or (`a'/2)=0 when a even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical.
		do
			Result := {MPZ_FUNCTIONS}.mpz_kronecker (a.item, b.item)
		end

	remove (v, f: GMP_INTEGER): GMP_INTEGER
			-- Remove all occurrences of the factor `f' from `v'.
			-- `factors_removed' is set to the number of factors removed.
		do
			create Result
			factors_removed := {MPZ_FUNCTIONS}.mpz_remove (Result.item, v.item, f.item)
		end

	factorial (v: NATURAL_32): GMP_INTEGER
			-- Factorial of `v'.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_fac_ui (Result.item, v)
		end

	binomial_coefficient (n: GMP_INTEGER; k: NATURAL_32): GMP_INTEGER
			-- Compute the binomial coefficient `n' over `k'.
			-- Negative values of `n' are supported using the identity bin(-`n',`k') = (-1)^`k' * bin(`n'+`k'-1,`k'),
			-- see Knuth volume 1 section 1.2.6 part G.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_bin_ui (Result.item, n.item, k)
		end

	fibonacci (n: NATURAL_32): GMP_INTEGER
			-- `n'-th Fibonacci number.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_fib_ui (Result.item, n)
		end

	lucas (n: NATURAL_32): GMP_INTEGER
			-- `n'-th Lucas number.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_lucnum_ui (Result.item, n)
		end

end
