note
	description: "C interface to mpq_t functions."
	author: "Chris Saunders"
	date: "$Date: 2010-06-02 (Wed, 02 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

-- NOTE: No functions that have a variable number of arguments are implemented in this class.
--		 Almost all comments are taken directly from the GMP documentation.

class
	MPQ_FUNCTIONS

feature -- Initialization

	mpq_init (x: POINTER)
			-- Initialize `x' and set it to 0/1.
			-- Each variable should normally only be initialized once, or at least cleared out (using the function `mpq_clear')
			-- between each initialization.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_init((mpq_ptr)$x);
			]"
		end

	mpq_canonicalize (op: POINTER)
			-- Remove any factors that are common to the numerator and denominator of `op', and make the denominator positive.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_canonicalize((mpq_ptr)$op);
			]"
		end

	mpq_clear (x: POINTER)
			-- Free the space occupied by `x'.
			-- Make sure to call this function for all mpq_t variables when you are done with them.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_clear((mpq_ptr)$x);
			]"
		end

	mpq_set (rop, op: POINTER)
			-- Assign `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set((mpq_ptr)$rop, (mpq_srcptr)$op);
			]"
		end

	mpq_set_z (rop, op: POINTER)
			-- Assign `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_z((mpq_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpq_set_ui (rop: POINTER; op1, op2: NATURAL_32)
			-- Set the value of `rop' to `op1'/`op2'.
			-- Note that if `op1' and `op2' have common factors, `rop' has to be passed to
			-- `mpq_canonicalize' before any operations are performed on `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_ui((mpq_ptr)$rop, (unsigned long int)$op1, (unsigned long int)$op2);
			]"
		end

	mpq_set_si (rop: POINTER; op1: INTEGER_32; op2: NATURAL_32)
			-- Set the value of `rop' to `op1'/`op2'.
			-- Note that if `op1' and `op2' have common factors, `rop' has to be passed to
			-- `mpq_canonicalize' before any operations are performed on `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_si((mpq_ptr)$rop, (signed long int)$op1, (unsigned long int)$op2);
			]"
		end

	mpq_set_str (rop, str: POINTER; base: INTEGER_32): INTEGER_32
			-- Set `rop' from a null-terminated string `str' in the given base `base'.
			-- The string can be an integer like "41" or a fraction like "41/152".
			-- The fraction must be in canonical form or if not then `mpq_canonicalize' must be called.
			-- The numerator and optional denominator are parsed the same as in `mpz_set_str' (see class MPZ_FUNCTIONS).
			-- White space is allowed in the string, and is simply ignored.
			-- `base' can vary from 2 to 62, or if base is 0 then the leading characters are used: 0x or 0X for hex,
			-- 0b or 0B for binary, 0 for octal, or decimal otherwise.
			-- Note that this is done separately for the numerator and denominator, so for instance 0xEF/100 is 239/100,
			-- whereas 0xEF/0x100 is 239/256.
			-- The return value is 0 if the entire string is a valid number, or ?1 if not.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_set_str((mpq_ptr)$rop, (const char *)$str, (int)$base);
			]"
		end

	mpq_swap (rop1, rop2: POINTER)
			-- Swap the values `rop1' and `rop2' efficiently.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_swap((mpq_ptr)$rop1, (mpq_ptr)$rop2);
			]"
		end

feature -- Conversion

	mpq_get_d (op: POINTER): REAL_64
			-- Convert `op' to a double, truncating if necessary (ie. rounding towards zero).
			-- If the exponent from the conversion is too big or too small to fit a double then the result is system dependent.
			-- For too big an infinity is returned when available.
			-- For too small 0.0 is normally returned.
			-- Hardware overflow, underflow and denorm traps may or may not occur.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (double)mpq_get_d((mpq_srcptr)$op);
			]"
		end

	mpq_set_d (rop: POINTER; op: REAL_64)
			-- Set `rop' to the value of `op'.
			-- There is no rounding, this conversion is exact.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_d((mpq_ptr)$rop, (double)$op);
			]"
		end

	mpq_set_f (rop, op: POINTER)
			-- Set `rop' to the value of `op'.
			-- There is no rounding, this conversion is exact.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_f((mpq_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpq_get_str (str: POINTER; base: INTEGER_32; op: POINTER): POINTER
			-- Convert `op' to a string of digits in base `base'.
			-- `base' may vary from 2 to 36.
			-- The string will be of the form `num/den', or if the denominator is 1 then just `num'.
			-- If `str' is NULL, the result string is allocated using the current allocation function.
			-- The block will be strlen(`str')+1 bytes, that being exactly enough for the string and null-terminator.
			-- If `str' is not NULL, it should point to a block of storage large enough for the result, that being
			--		`mpz_sizeinbase' (`mpq_numref'(`op'), `base') + `mpz_sizeinbase' (`mpq_denref'(`op'), `base') + 3
			-- The three extra bytes are for a possible minus sign, possible slash, and the null-terminator.
			-- A pointer to the result string is returned, being either the allocated block, or the given `str'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (char *)mpq_get_str((char *)$str, (int)$base, (mpq_srcptr)$op);
			]"
		end

feature -- Arithmetic

	mpq_add (sum, addend1, addend2: POINTER)
			-- Set `sum' to `addend1' + `addend2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_add((mpq_ptr)$sum, (mpq_srcptr)$addend1, (mpq_srcptr)$addend2);
			]"
		end

	mpq_sub (difference, minuend, subtrahend: POINTER)
			-- Set `difference' to `minuend' ? `subtrahend'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_sub((mpq_ptr)$difference, (mpq_srcptr)$minuend, (mpq_srcptr)$subtrahend);
			]"
		end

	mpq_mul (product, multiplier, multiplicand: POINTER)
			-- Set `product' to `multiplier' times `multiplicand'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_mul((mpq_ptr)$product, (mpq_srcptr)$multiplier, (mpq_srcptr)$multiplicand);
			]"
		end

	mpq_mul_2exp (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' times 2 raised to `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_mul_2exp((mpq_ptr)$rop, (mpq_srcptr)$op1, (mp_bitcnt_t)$op2);
			]"
		end

	mpq_div (quotient, dividend, divisor: POINTER)
			-- Set `product' to `multiplier' times `multiplicand'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_div((mpq_ptr)$quotient, (mpq_srcptr)$dividend, (mpq_srcptr)$divisor);
			]"
		end

	mpq_div_2exp (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' divided by 2 raised to `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_div_2exp((mpq_ptr)$rop, (mpq_srcptr)$op1, (mp_bitcnt_t)$op2);
			]"
		end

	mpq_neg (negated_operand, operand: POINTER)
			-- Set `negated_operand' to ?`operand'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_neg((mpq_ptr)$negated_operand, (mpq_srcptr)$operand);
			]"
		end

	mpq_abs (rop, op: POINTER)
			-- Set `rop' to the absolute value of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_abs((mpq_ptr)$rop, (mpq_srcptr)$op);
			]"
		end

	mpq_inv (inverted_number, number: POINTER)
			-- Set `inverted_number' to 1/`number'.
			-- If the new denominator is zero, this routine will divide by zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_inv((mpq_ptr)$inverted_number, (mpq_srcptr)$number);
			]"
		end

feature -- Comparison

	mpq_cmp (op1, op2: POINTER): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', and a negative value if `op1' < `op2'.
			-- To determine if two rationals are equal, `mpq_equal' is faster than `mpq_cmp'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_cmp((mpq_srcptr)$op1, (mpq_srcptr)$op2);
			]"
		end

	mpq_cmp_ui (op1: POINTER; num2, den2: NATURAL_32): INTEGER_32
			-- Compare `op1' and `num2'/`den2'.
			-- Return a positive value if `op1' > `num2'/`den2', zero if `op1' = `num2'/`den2', and a negative value if `op1' < `num2'/`den2'.
			-- `num2' and `den2' are allowed to have common factors.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_cmp_ui((mpq_srcptr)$op1, (unsigned long int)$num2, (unsigned long int)$den2);
			]"
		end

	mpq_cmp_si (op1: POINTER; num2: INTEGER_32; den2: NATURAL_32): INTEGER_32
			-- Compare `op1' and `num2'/`den2'.
			-- Return a positive value if `op1' > `num2'/`den2', zero if `op1' = `num2'/`den2', and a negative value if `op1' < `num2'/`den2'.
			-- `num2' and `den2' are allowed to have common factors.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_cmp_si((mpq_srcptr)$op1, (long)$num2, (unsigned long)$den2);
			]"
		end

	mpq_sgn (op: POINTER): INTEGER_32
			-- Return +1 if `op' > 0, 0 if `op' = 0, and -1 if `op' < 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_sgn((mpq_srcptr)$op);
			]"
		end

	mpq_equal (op1, op2: POINTER): INTEGER_32
			-- Return non-zero if `op1' and `op2' are equal, zero if they are non-equal.
			-- Although `mpq_cmp' can be used for the same purpose, this function is much faster.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpq_equal((mpq_srcptr)$op1, (mpq_srcptr)$op2);
			]"
		end

feature -- Applying integer functions to rationals

	mpq_numref (op: POINTER): POINTER
			-- Return a reference to the numerator of `op'.
			-- The mpz functions can be used on the result of this macro.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mpz_ptr)mpq_numref((mpq_srcptr)$op);
			]"
		end

	mpq_denref (op: POINTER): POINTER
			-- Return a reference to the denominator of `op'.
			-- The mpz functions can be used on the result of this macro.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mpz_ptr)mpq_denref((mpq_srcptr)$op);
			]"
		end

	mpq_get_num (numerator, rational: POINTER)
			-- Get the numerator of a rational.
			-- This function is equivalent to calling `mpz_set' with an appropriate `mpq_numref'.
			-- Direct use of `mpq_numref' is recommended instead of this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_get_num((mpz_ptr)$numerator, (mpq_srcptr)$rational);
			]"
		end

	mpq_get_den (denominator, rational: POINTER)
			-- Get the denominator of a rational.
			-- This function is equivalent to calling `mpz_set' with an appropriate `mpq_denref'.
			-- Direct use of `mpq_denref' is recommended instead of this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_get_den((mpz_ptr)$denominator, (mpq_srcptr)$rational);
			]"
		end

	mpq_set_num (rational, numerator: POINTER)
			-- Set the numerator of a rational.
			-- This function is equivalent to calling `mpz_set' with an appropriate `mpq_numref'.
			-- Direct use of `mpq_numref' is recommended instead of this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_num((mpq_ptr)$rational, (mpz_srcptr)$numerator);
			]"
		end

	mpq_set_den (rational, denominator: POINTER)
			-- Set the denominator of a rational.
			-- This function is equivalent to calling `mpz_set' with an appropriate `mpq_denref'.
			-- Direct use of `mpq_denref' is recommended instead of this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpq_set_den((mpq_ptr)$rational, (mpz_srcptr)$denominator);
			]"
		end

feature -- Input and output

	mpq_out_str (stream: POINTER; base: INTEGER_32; op: POINTER): NATURAL_64
			-- Output `op' on stdio stream `stream', as a string of digits in base `base'.
			-- `base' may vary from 2 to 36.
			-- Output is in the form `num/den' or if the denominator is 1 then just `num'.
			-- Return the number of bytes written, or if an error occurred, return 0.
			-- Passing a NULL pointer for `stream' will make it write to stdout.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpq_out_str((FILE *)$stream, (int)$base, (mpq_srcptr)$op);
			]"
		end

	mpq_inp_str (rop, stream: POINTER; base: INTEGER_32): NATURAL_64
			-- Read a string of digits from `stream' and convert them to a rational in `rop'.
			-- Any initial white-space characters are read and discarded.
			-- Return the number of characters read (including white space), or 0 if a rational could not be read.
			-- The input can be a fraction like `17/63' or just an integer like `123'.
			-- Reading stops at the first character not in this form, and white space is not permitted within the string.
			-- If the input might not be in canonical form, then `mpq_canonicalize' must be called.
			-- `base' can be between 2 and 36, or can be 0 in which case the leading characters of the string determine the base,
			-- `0x' or `0X' for hexadecimal, `0' for octal, or decimal otherwise.
			-- The leading characters are examined separately for the numerator and denominator of a fraction, so for instance
			-- `0x10/11' is 16/11, whereas `0x10/0x11' is 16/17.
			-- Passing a NULL pointer for `stream' will make it read from stdin.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpq_inp_str((mpq_ptr)$rop, (FILE *)$stream, (int)$base);
			]"
		end

end
