note
	description: "C interface to mpf_t functions."
	author: "Chris Saunders"
	date: "$Date: 2010-06-02 (Wed, 02 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

-- NOTE: No functions that have a variable number of arguments are implemented in this class.
--		 Almost all comments are taken directly from the GMP documentation.

class
	MPF_FUNCTIONS

feature -- Initialization

	mpf_set_default_prec (prec: NATURAL_32)
			-- Set the default precision to be at least `prec' bits.
			-- All subsequent calls to `mpf_init' will use this precision, but previously initialized variables are unaffected.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_default_prec((mp_bitcnt_t)$prec);
			]"
		end

	mpf_get_default_prec: NATURAL_32
			-- Return the default precision actually used.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpf_get_default_prec();
			]"
		end

	mpf_init (x: POINTER)
			-- Initialize `x' to 0.
			-- Normally, a variable should be initialized once only or at least be cleared, using `mpf_clear', between initializations.
			-- The precision of `x' is undefined unless a default precision has already been established by a call to `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init((mpf_ptr)$x);
			]"
		end

	mpf_init2 (x: POINTER; prec: NATURAL_32)
			-- Initialize `x' to 0 and set its precision to be at least `prec' bits.
			-- Normally, a variable should be initialized once only or at least be cleared, using `mpf_clear', between initializations.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init2((mpf_ptr)$x, (mp_bitcnt_t)$prec);
			]"
		end

	mpf_clear (x: POINTER)
			-- Free the space occupied by `x'.
			-- Make sure to call this function for all mpf_t variables when you are done with them.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_clear((mpf_ptr)$x);
			]"
		end

	mpf_get_prec (op: POINTER): NATURAL_32
			-- Return the current precision of `op', in bits.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpf_get_prec((mpf_srcptr)$op);
			]"
		end

	mpf_set_prec (rop: POINTER; prec: NATURAL_32)
			-- Set the precision of `rop' to be at least `prec' bits.
			-- The value in `rop' will be truncated to the new precision.
			-- This function requires a call to realloc, and so should not be used in a tight loop.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_prec((mpf_ptr)$rop, (mp_bitcnt_t)$prec);
			]"
		end

	mpf_set_prec_raw (rop: POINTER; prec: NATURAL_32)
			-- Set the precision of `rop' to be at least `prec' bits, without changing the memory allocated.
			-- `prec' must be no more than the allocated precision for `rop', that being the precision when `rop' was initialized,
			-- or in the most recent `mpf_set_prec'.
			-- The value in `rop' is unchanged, and in particular if it had a higher precision than `prec' it will retain that higher precision.
			-- New values written to `rop' will use the new `prec'.
			-- Before calling `mpf_clear' or the full `mpf_set_prec', another `mpf_set_prec_raw' call must be made to restore `rop' to its original
			-- allocated precision.
			-- Failing to do so will have unpredictable results.
			-- `mpf_get_prec' can be used before `mpf_set_prec_raw' to get the original allocated precision.
			-- After `mpf_set_prec_raw' it reflects the `prec' value set.
			-- `mpf_set_prec_raw' is an efficient way to use an mpf_t variable at different precisions during a calculation, perhaps to gradually
			-- increase precision in an iteration, or just to use various different precisions for different purposes during a calculation.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_prec_raw((mpf_ptr)$rop, (mp_bitcnt_t)$prec);
			]"
		end

feature -- Assignment

	mpf_set (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_set_ui (rop: POINTER; op: NATURAL_32)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_ui((mpf_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpf_set_si (rop: POINTER; op: INTEGER_32)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_si((mpf_ptr)$rop, (signed long int)$op);
			]"
		end

	mpf_set_d (rop: POINTER; op: REAL_64)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_d((mpf_ptr)$rop, (double)$op);
			]"
		end

	mpf_set_z (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_z((mpf_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpf_set_q (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_set_q((mpf_ptr)$rop, (mpq_srcptr)$op);
			]"
		end

	mpf_set_str (rop, str: POINTER; base: INTEGER_32): INTEGER_32
			-- Set the value of `rop' from the string in `str'.
			-- The string is of the form `M@N' or, if the base is 10 or less, alternatively `MeN'.
			-- `M' is the mantissa and `N' is the exponent.
			-- The mantissa is always in the specified `base'.
			-- The exponent is either in the specified `base' or, if `base' is negative, in decimal.
			-- The decimal point expected is taken from the current locale, on systems providing localeconv.
			-- `base' may be in the ranges 2 to 62, or ?62 to ?2.
			-- Negative values are used to specify that the exponent is in decimal.
			-- For bases up to 36, case is ignored; upper-case and lower-case letters have the same value; for bases 37 to 62,
			-- upper-case letter represent the usual 10..35 while lower-case letter represent 36..61.
			-- Unlike the corresponding mpz function, the base will not be determined from the leading characters of the string if base is 0.
			-- This is so that numbers like `0.23' are not interpreted as octal.
			-- White space is allowed in the string, and is simply ignored. [This is not really true; white-space is ignored in the beginning
			-- of the string and within the mantissa, but not in other places, such as after a minus sign or in the exponent.
			-- This function returns 0 if the entire string is a valid number in base `base'.
			-- Otherwise it returns ?1.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_set_str((mpf_ptr)$rop, (const char *)$str, (int)$base);
			]"
		end

	mpf_swap (rop1, rop2: POINTER)
			-- Swap `rop1' and `rop2' efficiently.
			-- Both the values and the precisions of the two variables are swapped.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_swap((mpf_ptr)$rop1, (mpf_ptr)$rop2);
			]"
		end

feature -- Combined initialization and assignment

	mpf_init_set (rop, op: POINTER)
			-- Initialize `rop' and set its value from `op'.
			-- The precision of `rop' will be taken from the active default precision, as set by `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init_set((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_init_set_ui (rop: POINTER; op: NATURAL_32)
			-- Initialize `rop' and set its value from `op'.
			-- The precision of `rop' will be taken from the active default precision, as set by `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init_set_ui((mpf_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpf_init_set_si (rop: POINTER; op: INTEGER_32)
			-- Initialize `rop' and set its value from `op'.
			-- The precision of `rop' will be taken from the active default precision, as set by `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init_set_si((mpf_ptr)$rop, (signed long int)$op);
			]"
		end

	mpf_init_set_d (rop: POINTER; op: REAL_64)
			-- Initialize `rop' and set its value from `op'.
			-- The precision of `rop' will be taken from the active default precision, as set by `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_init_set_d((mpf_ptr)$rop, (double)$op);
			]"
		end

	mpf_init_set_str (rop, str: POINTER; base: INTEGER_32): INTEGER_32
			-- Initialize `rop' and set its value from the string in `str'.
			-- See `mpf_set_str' above for details on the assignment operation.
			-- Note that `rop' is initialized even if an error occurs. (I.e., you have to call `mpf_clear' for it.)
			-- The precision of `rop' will be taken from the active default precision, as set by `mpf_set_default_prec'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_init_set_str((mpf_ptr)$rop, (const char *)$str, (int)$base);
			]"
		end

feature -- Conversion

	mpf_get_d (op: POINTER): REAL_64
			-- Convert `op' to a double, truncating if necessary (ie. rounding towards zero).
			-- If the exponent in `op' is too big or too small to fit a double then the result is system dependent.
			-- For too big an infinity is returned when available.
			-- For too small 0.0 is normally returned.
			-- Hardware overflow, underflow and denorm traps may or may not occur.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (double)mpf_get_d((mpf_srcptr)$op);
			]"
		end

	mpf_get_d_2exp (exp: TYPED_POINTER [INTEGER_32]; op: POINTER): REAL_64
			-- Convert `op' to a double, truncating if necessary (ie. rounding towards zero), and with an exponent returned separately.
			-- The return value is in the range 0.5<=abs(`d')<1 and the exponent is stored to *`exp'.
			-- `d' * 2^`exp' is the (truncated) `op' value.
			-- If `op' is zero, the return is 0.0 and 0 is stored to *`exp'.
			-- This is similar to the standard C frexp function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (double)mpf_get_d_2exp((signed long int *)$exp, (mpf_srcptr)$op);
			]"
		end

	mpf_get_si (op: POINTER): INTEGER_32
			-- Convert `op' to a long truncating any fraction part.
			-- If `op' is too big for the return type, the result is undefined.
			-- See also `mpf_fits_slong_p'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (long)mpf_get_si((mpf_srcptr)$op);
			]"
		end

	mpf_get_ui (op: POINTER): NATURAL_32
			-- Convert `op' to a unsigned long truncating any fraction part.
			-- If `op' is too big for the return type, the result is undefined.
			-- See also `mpf_fits_ulong_p'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long)mpf_get_ui((mpf_srcptr)$op);
			]"
		end

	mpf_get_str (str: POINTER; expptr: TYPED_POINTER [INTEGER_32]; base: INTEGER_32; n_digits: NATURAL_64; op: POINTER): POINTER
			-- Convert `op' to a string of digits in base `base'.
			-- `base' may vary from 2 to 62 or from ?2 to ?36.
			-- Up to `n_digits' digits will be generated.
			-- Trailing zeros are not returned.
			-- No more digits than can be accurately represented by `op' are ever generated.
			-- If `n_digits' is 0 then that accurate maximum number of digits are generated.
			-- For `base' in the range 2..36, digits and lower-case letters are used; for ?2..?36, digits and upper-case letters
			-- are used; for 37..62, digits, upper-case letters, and lower-case letters (in that significance order) are used.
			-- If `str' is NULL, the result string is allocated using the current allocation function.
			-- The block will be strlen(`str')+1 bytes, that being exactly enough for the string and null-terminator.
			-- If `str' is not NULL, it should point to a block of `n_digits' + 2 bytes, that being enough for the mantissa, a
			-- possible minus sign, and a null-terminator.
			-- When `n_digits' is 0 to get all significant digits, an application won't be able to know the space required, and
			-- `str' should be NULL in that case.
			-- The generated string is a fraction, with an implicit radix point immediately to the left of the first digit.
			-- The applicable exponent is written through the `expptr' pointer.
			-- For example, the number 3.1416 would be returned as string "31416" and exponent 1.
			-- When `op' is zero, an empty string is produced and the exponent returned is 0.
			-- A pointer to the result string is returned, being either the allocated block or the given `str'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (char *)mpf_get_str((char *)$str, (mp_exp_t *)$expptr, (int)$base, (size_t)$n_digits, (mpf_srcptr)$op);
			]"
		end

feature -- Arithmetic

	mpf_add (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' + `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_add((mpf_ptr)$rop, (mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_add_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' + `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_add_ui((mpf_ptr)$rop, (mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_sub (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_sub((mpf_ptr)$rop, (mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_ui_sub (rop: POINTER; op1: NATURAL_32; op2: POINTER)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_ui_sub((mpf_ptr)$rop, (unsigned long int)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_sub_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_sub_ui((mpf_ptr)$rop, (mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_mul (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' * `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_mul((mpf_ptr)$rop, (mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_mul_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' * `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_mul_ui((mpf_ptr)$rop, (mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_div (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' / `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_div((mpf_ptr)$rop, (mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_ui_div (rop: POINTER; op1: NATURAL_32; op2: POINTER)
			-- Set `rop' to `op1' / `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_ui_div((mpf_ptr)$rop, (unsigned long int)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_div_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' / `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_div_ui((mpf_ptr)$rop, (mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_sqrt (rop, op: POINTER)
			-- Set `rop' to the square root of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_sqrt((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_sqrt_ui (rop: POINTER; op: NATURAL_32)
			-- Set `rop' to the square root of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_sqrt_ui((mpf_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpf_pow_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' raised to the power `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_pow_ui((mpf_ptr)$rop, (mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_neg (rop, op: POINTER)
			-- Set `rop' to ?`op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_neg((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_abs (rop, op: POINTER)
			-- Set `rop' to the absolute value of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_abs((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_mul_2exp (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' times 2 raised to `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_mul_2exp((mpf_ptr)$rop, (mpf_srcptr)$op1, (mp_bitcnt_t)$op2);
			]"
		end

	mpf_div_2exp (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' divided by 2 raised to `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_div_2exp((mpf_ptr)$rop, (mpf_srcptr)$op1, (mp_bitcnt_t)$op2);
			]"
		end

feature -- Comparison

	mpf_cmp (op1, op2: POINTER): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', and a negative value if `op1' < `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_cmp((mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_cmp_d (op1: POINTER; op2: REAL_64): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', and a negative value if `op1' < `op2'.
			-- Can be called with an infinity, but results are undefined for a NaN.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_cmp_d((mpf_srcptr)$op1, (double)$op2);
			]"
		end

	mpf_cmp_ui (op1: POINTER; op2: NATURAL_32): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', and a negative value if `op1' < `op2'.
			-- Can be called with an infinity, but results are undefined for a NaN.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_cmp_ui((mpf_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpf_cmp_si (op1: POINTER; op2: INTEGER_32): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', and a negative value if `op1' < `op2'.
			-- Can be called with an infinity, but results are undefined for a NaN.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_cmp_si((mpf_srcptr)$op1, (signed long int)$op2);
			]"
		end

	mpf_eq (op1, op2: POINTER; op3: NATURAL_32): INTEGER_32
			-- Return non-zero if the first `op3' bits of `op1' and `op2' are equal, zero otherwise. I.e.,
			-- test if `op1' and `op2' are approximately equal.
			-- Caution 1: All version of GMP up to version 4.2.4 compared just whole limbs, meaning sometimes
			-- more than op3 bits, sometimes fewer.
			-- Caution 2: This function will consider XXX11...111 and XX100...000 different, even if ... is replaced
			-- by a semi-infinite number of bits.
			-- Such numbers are really just one ulp off, and should be considered equal.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_eq((mpf_srcptr)$op1, (mpf_srcptr)$op2, (unsigned long int)$op3);
			]"
		end

	mpf_reldiff (rop, op1, op2: POINTER)
			-- Compute the relative difference between `op1' and `op2' and store the result in `rop'.
			-- This is abs(`op1'-`op2')/`op1'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_reldiff((mpf_ptr)$rop, (mpf_srcptr)$op1, (mpf_srcptr)$op2);
			]"
		end

	mpf_sgn (op: POINTER): INTEGER_32
			-- Return +1 if `op' > 0, 0 if `op' = 0, and -1 if `op' < 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_sgn((mpf_srcptr)$op);
			]"
		end

feature -- Input and output

	mpf_out_str (stream: POINTER; base: INTEGER_32; n_digits: NATURAL_64; op: POINTER): NATURAL_64
			-- Print `op' to `stream', as a string of digits.
			-- Return the number of bytes written, or if an error occurred, return 0.
			-- The mantissa is prefixed with an `0.' and is in the given `base', which may vary from 2 to 62 or from ?2 to ?36.
			-- An exponent is then printed, separated by an `e', or if the base is greater than 10 then by an `@'.
			-- The exponent is always in decimal.
			-- The decimal point follows the current locale, on systems providing localeconv.
			-- For `base' in the range 2..36, digits and lower-case letters are used; for ?2..?36, digits and upper-case letters
			-- are used; for 37..62, digits, upper-case letters, and lower-case letters (in that significance order) are used.
			-- Up to `n_digits' will be printed from the mantissa, except that no more digits than are accurately representable
			-- by `op' will be printed.
			-- `n_digits' can be 0 to select that accurate maximum.
			-- Passing a NULL pointer for `stream' will make this function write to stdout.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpf_out_str((FILE *)$stream, (int)$base, (size_t)$n_digits, (mpf_srcptr)$op);
			]"
		end

	mpf_inp_str (rop, stream: POINTER; base: INTEGER_32): NATURAL_64
			-- Read a string in base `base' from `stream', and put the read float in `rop'.
			-- The string is of the form `M@N' or, if `base' is 10 or less, alternatively `MeN'.
			-- `M' is the mantissa and `N' is the exponent.
			-- The mantissa is always in the specified `base'.
			-- The exponent is either in the specified `base' or, if `base' is negative, in decimal.
			-- The decimal point expected is taken from the current locale, on systems providing localeconv.
			-- `base' may be in the ranges 2 to 36, or ?36 to ?2.
			-- Negative values are used to specify that the exponent is in decimal.
			-- Unlike the corresponding mpz function, the base will not be determined from the leading characters
			-- of the string if `base' is 0.
			-- This is so that numbers like `0.23' are not interpreted as octal.
			-- Return the number of bytes read, or if an error occurred, return 0.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpf_inp_str((mpf_ptr)$rop, (FILE *)$stream, (int)$base);
			]"
		end

feature -- Miscellaneous

	mpf_ceil (rop, op: POINTER)
			-- Set `rop' to `op' rounded to an integer.
			-- Rounds to the next higher integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_ceil((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_floor (rop, op: POINTER)
			-- Set `rop' to `op'  rounded to an integer.
			-- Rounds to the next lower integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_floor((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_trunc (rop, op: POINTER)
			-- Set `rop' to `op'  rounded to an integer.
			-- Rounds to the integer towards zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_trunc((mpf_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpf_integer_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' is an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_integer_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_ulong_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_ulong_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_slong_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_slong_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_uint_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_uint_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_sint_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_sint_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_ushort_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_ushort_p((mpf_srcptr)$op);
			]"
		end

	mpf_fits_sshort_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' would fit in the respective C data type, when truncated to an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpf_fits_sshort_p((mpf_srcptr)$op);
			]"
		end

	mpf_urandomb (rop, state: POINTER; nbits: NATURAL_32)
			-- Generate a uniformly distributed random float in `rop', such that 0 <= `rop' < 1, with `nbits' significant bits in the mantissa.
			-- `state' must be initialized by calling one of the gmp_randinit functions (see class RANDOM_STATE_INITIALIZATION) before invoking
			-- this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_urandomb((mpf_ptr)$rop, (__gmp_randstate_struct *)$state, (mp_bitcnt_t)$nbits);
			]"
		end

	mpf_random2 (rop: POINTER; max_size, exp: INTEGER_32)
			-- Generate a random float of at most `max_size' limbs, with long strings of zeros and ones in the binary representation.
			-- The exponent of the number is in the interval ?`exp' to `exp' (in limbs).
			-- This function is useful for testing functions and algorithms, since these kind of random numbers have proven to be more
			-- likely to trigger corner-case bugs.
			-- Negative random numbers are generated when `max_size' is negative.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpf_random2((mpf_ptr)$rop, (mp_size_t)$max_size, (mp_exp_t)$exp);
			]"
		end

end
