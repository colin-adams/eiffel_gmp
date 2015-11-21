note
	description: "C interface to mpz_t functions."
	author: "Chris Saunders"
	date: "$Date: 2010-05-31 (Mon, 31 May 2010) $"
	revision: "$Revision: 1.0.0.0 $"

-- NOTE: No functions that have a variable number of arguments are implemented in this class.
--		 Almost all comments are taken directly from the GMP documentation.

class
	MPZ_FUNCTIONS

feature -- Initialization

	mpz_init (x: POINTER)
			-- Initialize `x', and set its value to 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init((mpz_ptr)$x);
			]"
		end

	mpz_init2 (x: POINTER; n: NATURAL_32)
			-- Initialize `x', with space for `n'-bit numbers, and set its value to 0.
			-- Calling this function instead of mpz_init is never necessary; reallocation is handled automatically by GMP when needed
			-- `n' is only the initial space, `x' will grow automatically in the normal way, if necessary, for subsequent values stored.
			-- `mpz_init2' makes it possible to avoid such reallocations if a maximum size is known in advance.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init2((mpz_ptr)$x, (mp_bitcnt_t)$n);
			]"
		end

	mpz_clear (x: POINTER)
			-- Free the space occupied by `x'.
			-- Call this function for all mpz_t variables when you are done with them.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_clear((mpz_ptr)$x);
			]"
		end

	mpz_realloc2 (x: POINTER; n: NATURAL_32)
			-- Change the space allocated for `x' to `n' bits.
			-- The value in `x' is preserved if it fits, or is set to 0 if not.
			-- Calling this function is never necessary; reallocation is handled automatically by GMP when needed.
			-- But this function can be used to increase the space for a variable in order to avoid repeated automatic
			-- reallocations, or to decrease it to give memory back to the heap.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_realloc2((mpz_ptr)$x, (mp_bitcnt_t)$n);
			]"
		end

feature -- Assignment

	mpz_set (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set((mpz_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpz_set_ui (rop: POINTER; op: NATURAL_32)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set_ui((mpz_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpz_set_si (rop: POINTER; op: INTEGER_32)
			-- Set the value of `rop' from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set_si((mpz_ptr)$rop, (signed long int)$op);
			]"
		end

	mpz_set_d (rop: POINTER; op: REAL_64)
			-- Set the value of `rop' from `op'.
			-- Truncate `op' to make it an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set_d((mpz_ptr)$rop, (double)$op);
			]"
		end

	mpz_set_q (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
			-- Truncate `op' to make it an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set_q((mpz_ptr)$rop, (mpq_srcptr)$op);
			]"
		end

	mpz_set_f (rop, op: POINTER)
			-- Set the value of `rop' from `op'.
			-- Truncate `op' to make it an integer.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_set_f((mpz_ptr)$rop, (mpf_srcptr)$op);
			]"
		end

	mpz_set_str (rop, str: POINTER; base: INTEGER_32): INTEGER_32
			-- Set the value of `rop' from `str', a null-terminated C string in base `base'.
			-- White space is allowed in the string, and is simply ignored.
			-- `base' may vary from 2 to 62, or if base is 0, then the leading characters are used:
			--		0x and 0X for hexadecimal, 0b and 0B for binary, 0 for octal, or decimal otherwise.
			-- For bases up to 36, case is ignored; upper-case and lower-case letters have the same value.
			-- For bases 37 to 62, upper-case letter represent the usual 10..35 while lower-case letter represent 36..61.
			-- This function returns 0 if the entire string is a valid number in base `base'.
			-- Otherwise it returns -1.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_set_str((mpz_ptr)$rop, (char *)$str, (int)$base);
			]"
		end

	mpz_swap (rop1, rop2: POINTER)
			-- Swap the values `rop1' and `rop2' efficiently.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_swap((mpz_ptr)$rop1, (mpz_ptr)$rop2);
			]"
		end

feature -- Combined initialization and assignment

	mpz_init_set (rop, op: POINTER)
			-- Initialize `rop' with limb space and set the initial numeric value from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init_set((mpz_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpz_init_set_ui (rop: POINTER; op: NATURAL_32)
			-- Initialize `rop' with limb space and set the initial numeric value from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init_set_ui((mpz_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpz_init_set_si (rop: POINTER; op: INTEGER_32)
			-- Initialize `rop' with limb space and set the initial numeric value from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init_set_si((mpz_ptr)$rop, (signed long int)$op);
			]"
		end

	mpz_init_set_d (rop: POINTER; op: REAL_64)
			-- Initialize `rop' with limb space and set the initial numeric value from `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_init_set_d((mpz_ptr)$rop, (double)$op);
			]"
		end

	mpz_init_set_str (rop, str: POINTER; base: INTEGER_32): INTEGER_32
			-- Initialize `rop' and set its value like `mpz_set_str' (see its documentation above for details).
			-- If the string is a correct base `base' number, the function returns 0; if an error occurs it returns -1.
			-- `rop' is initialized even if an error occurs. (I.e., you have to call `mpz_clear' for it.)
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_init_set_str((mpz_ptr)$rop, (const char *)$str, (int)$base);
			]"
		end

feature -- Conversion

	mpz_get_ui (op: POINTER): NATURAL_32
			-- Return the value of `op; as an unsigned long.
			-- If `op' is too big to fit an unsigned long then just the least significant bits that do fit are returned.
			-- The sign of `op' is ignored, only the absolute value is used.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_get_ui((mpz_srcptr)$op);
			]"
		end

	mpz_get_si (op: POINTER): INTEGER_32
			-- If `op' fits into a signed long int return the value of `op'.
			-- Otherwise return the least significant part of `op', with the same sign as `op'.
			-- If `op' is too big to fit in a signed long int, the returned result is probably not very useful.
			-- To find out if the value will fit, use the function `mpz_fits_slong_p'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (long int)mpz_get_si((mpz_srcptr)$op);
			]"
		end

	mpz_get_d (op: POINTER): REAL_64
			-- Convert `op' to a double, truncating if necessary (ie. rounding towards zero).
			-- If the exponent from the conversion is too big, the result is system dependent.
			-- An infinity is returned where available.
			-- A hardware overflow trap may or may not occur.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (double)mpz_get_d((mpz_srcptr)$op);
			]"
		end

	mpz_get_d_2exp (exp: TYPED_POINTER [INTEGER_32]; op: POINTER): REAL_64
			-- Convert `op' to a double, truncating if necessary (ie. rounding towards zero), and returning the exponent separately.
			-- The return value is in the range 0.5<=abs(d)<1 and the exponent is stored to *exp.
			-- d * 2^exp is the (truncated) `op' value.
			-- If `op' is zero, the return is 0.0 and 0 is stored to *exp.
			-- This is similar to the standard C frexp function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (double)mpz_get_d_2exp((signed long int *)$exp, (mpz_srcptr)$op);
			]"
		end

	mpz_get_str (str: POINTER; base: INTEGER_32; op: POINTER): POINTER
			-- Convert `op' to a string of digits in base `base'.
			-- The base argument may vary from 2 to 62 or from ?2 to ?36.
			-- For `base' in the range 2..36, digits and lower-case letters are used; for ?2..?36, digits and upper-case letters are used;
			-- for 37..62, digits, upper-case letters, and lower-case letters (in that significance order) are used.
			-- If `str' is NULL, the result string is allocated using the current allocation function (No custom allotation is provided in this library).
			-- The block will be strlen(str)+1 bytes, that being exactly enough for the string and null-terminator.
			-- If `str' is not NULL, it should point to a block of storage large enough for the result, that being mpz_sizeinbase (op, base) + 2.
			-- The two extra bytes are for a possible minus sign, and the null-terminator.
			-- A pointer to the result string is returned, being either the allocated block, or the given `str'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (char *)mpz_get_str((char *)$str, (int)$base, (mpz_srcptr)$op);
			]"
		end

feature -- Arithmetic

	mpz_add (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' + `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_add((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_add_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' + `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_add_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_sub (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_sub((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_sub_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_sub_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_ui_sub (rop: POINTER; op1: NATURAL_32; op2: POINTER)
			-- Set `rop' to `op1' - `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_ui_sub((mpz_ptr)$rop, (unsigned long int)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_mul (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' * `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_mul((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_mul_si (rop, op1: POINTER; op2: INTEGER_32)
			-- Set `rop' to `op1' * `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_mul_si((mpz_ptr)$rop, (mpz_srcptr)$op1, (long int)$op2);
			]"
		end

	mpz_mul_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' * `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_mul_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_addmul (rop, op1, op2: POINTER)
			-- Set `rop' to `rop' + `op1' times `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_addmul((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_addmul_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `rop' + `op1' times `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_addmul_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_submul (rop, op1, op2: POINTER)
			-- Set `rop' to `rop' - `op1' times `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_submul((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_submul_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `rop' - `op1' times `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_submul_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_mul_2exp (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to `op1' times 2 raised to `op2'.
			-- This operation can also be defined as a left shift by op2 bits.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_mul_2exp((mpz_ptr)$rop, (mpz_srcptr)$op1, (mp_bitcnt_t)$op2);
			]"
		end

	mpz_neg (rop, op: POINTER)
			-- Set `rop' to ?`op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_neg((mpz_ptr)$rop, (mpz_srcptr)$op)
			]"
		end

	mpz_abs (rop, op: POINTER)
			-- Set `rop' to ?`op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_abs((mpz_ptr)$rop, (mpz_srcptr)$op)
			]"
		end

feature -- Division

		-- Division is undefined if the divisor is zero. Passing a zero divisor to the division or modulo functions (including the
		-- modular powering functions mpz_powm and mpz_powm_ui), will cause an intentional division by zero. This lets a program handle
		-- arithmetic exceptions in these functions the same way as for normal C int arithmetic.

		-- Divide n by d, forming a quotient q and/or remainder r. For the 2exp functions, d=2^b.  The rounding is in three styles,
		-- each suiting different applications.
		--		cdiv rounds q up towards +infinity, and r will have the opposite sign to d. The c stands for "ceil".
		--		fdiv rounds q down towards ?infinity, and r will have the same sign as d. The f stands for "floor".
		--		tdiv rounds q towards zero, and r will have the same sign as n. The t stands for "truncate".

		-- In all cases q and r will satisfy n=q*d+r, and r will satisfy 0<=abs(r)<abs(d).

		-- The q functions calculate only the quotient, the r functions only the remainder, and the qr functions calculate both.
		-- Note that for qr the same variable cannot be passed for both q and r, or results will be unpredictable.

		-- For the ui variants the return value is the remainder, and in fact returning the remainder is all the div_ui functions do.
		-- For tdiv and cdiv the remainder can be negative, so for those the return value is the absolute value of the remainder.

		-- For the 2exp variants the divisor is 2^`b'. These functions are implemented as right shifts and bit masks, but of course they
		-- round the same as the other functions.

		-- For positive `n' both `mpz_fdiv_q_2exp' and `mpz_tdiv_q_2exp' are simple bitwise right shifts. For negative `n', `mpz_fdiv_q_2exp'
		-- is effectively an arithmetic right shift treating n as twos complement the same as the bitwise logical functions do, whereas
		-- `mpz_tdiv_q_2exp' effectively treats n as sign and magnitude.

	mpz_cdiv_q (q, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_cdiv_q((mpz_ptr)$q, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_cdiv_r (r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_cdiv_r((mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_cdiv_qr (q, r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_cdiv_qr((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_cdiv_q_ui (q, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_cdiv_q_ui((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_cdiv_r_ui (r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_cdiv_r_ui((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_cdiv_qr_ui (q, r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_cdiv_qr_ui((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_cdiv_ui (n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_cdiv_ui((mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_cdiv_q_2exp (q, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_cdiv_q_2exp((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_cdiv_r_2exp (r, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_cdiv_r_2exp((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_fdiv_q (q, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fdiv_q((mpz_ptr)$q, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_fdiv_r (r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fdiv_r((mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_fdiv_qr (q, r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fdiv_qr((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_fdiv_q_ui (q, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_fdiv_q_ui((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_fdiv_r_ui (r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_fdiv_r_ui((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_fdiv_qr_ui (q, r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_fdiv_qr_ui((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_fdiv_ui (n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_fdiv_ui((mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_fdiv_q_2exp (q, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fdiv_q_2exp((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_fdiv_r_2exp (r, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fdiv_r_2exp((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_tdiv_q (q, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_tdiv_q((mpz_ptr)$q, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_tdiv_r (r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_tdiv_r((mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_tdiv_qr (q, r, n, d: POINTER)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_tdiv_qr((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_tdiv_q_ui (q, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_tdiv_q_ui((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_tdiv_r_ui (r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_tdiv_r_ui((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_tdiv_qr_ui (q, r, n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_tdiv_qr_ui((mpz_ptr)$q, (mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_tdiv_ui (n: POINTER; d: NATURAL_32): NATURAL_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_tdiv_ui((mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_tdiv_q_2exp (q, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_tdiv_q_2exp((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_tdiv_r_2exp (r, n: POINTER; b: NATURAL_32)
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_tdiv_r_2exp((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long)$b);
			]"
		end

	mpz_mod (r, n, d: POINTER)
			-- Set `r' to `n' mod `d'.
			-- The sign of the divisor is ignored; the result is always non-negative.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_mod((mpz_ptr)$r, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_mod_ui (r, n: POINTER; d: NATURAL_32): NATURAL_32
			-- Set `r' to `n' mod `d'.
			-- The sign of the divisor is ignored; the result is always non-negative.
			-- Is identical to `mpz_fdiv_r_ui' above, returning the remainder as well as setting `r'.
			-- See `mpz_fdiv_ui' above if only the return value is wanted.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_mod_ui((mpz_ptr)$r, (mpz_srcptr)$n, (unsigned long int)$d);
			]"
		end

	mpz_divexact (q, n, d: POINTER)
			-- Set `q' to `n'/`d'.
			-- This function produces correct results only when it is known in advance that `d' divides `n'.
			-- This routines is much faster than the other division functions, and is the best choice when exact
			-- division is known to occur, for example reducing a rational to lowest terms.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_divexact((mpz_ptr)$q, (mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_divexact_ui (q, n: POINTER; d: NATURAL_32)
			-- Set `q' to `n'/`d'.
			-- This function produces correct results only when it is known in advance that `d' divides `n'.
			-- This routines is much faster than the other division functions, and is the best choice when exact
			-- division is known to occur, for example reducing a rational to lowest terms.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_divexact_ui((mpz_ptr)$q, (mpz_srcptr)$n, (unsigned long)$d);
			]"
		end

	mpz_divisible_p (n, d: POINTER): INTEGER_32
			-- Return non-zero if `n' is exactly divisible by `d'.
			-- `n' is divisible by `d' if there exists an integer q satisfying `n' = q*`d'.
			-- Unlike the other division functions, `d'=0 is accepted and following the rule
			-- it can be seen that only 0 is considered divisible by 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_divisible_p((mpz_srcptr)$n, (mpz_srcptr)$d);
			]"
		end

	mpz_divisible_ui_p (n: POINTER; d: NATURAL_32): INTEGER_32
			-- Return non-zero if `n' is exactly divisible by `d'.
			-- `n' is divisible by `d' if there exists an integer q satisfying `n' = q*`d'.
			-- Unlike the other division functions, `d'=0 is accepted and following the rule
			-- it can be seen that only 0 is considered divisible by 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_divisible_ui_p((mpz_srcptr)$n, (unsigned long)$d);
			]"
		end

	mpz_divisible_2exp_p (n: POINTER; b: NATURAL_32): INTEGER_32
			-- Return non-zero if `n' is exactly divisible by 2^`b'.
			-- `n' is divisible by 2^`b' if there exists an integer q satisfying `n' = q*2^`b'.
			-- Unlike the other division functions, 2^`b'=0 is accepted and following the rule
			-- it can be seen that only 0 is considered divisible by 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_divisible_2exp_p((mpz_srcptr)$n, (mp_bitcnt_t)$b);
			]"
		end

	mpz_congruent_p (n, c, d: POINTER): INTEGER_32
			-- Return non-zero if `n' is congruent to `c' modulo `d'.
			-- `n' is congruent to `c' mod `d' if there exists an integer q satisfying `n' = `c' + q*`d'.
			-- Unlike the other division functions, `d'=0 is accepted and following the rule it can be seen that `n'
			-- and `c' are considered congruent mod 0 only when exactly equal.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_congruent_p((mpz_srcptr)$n, (mpz_srcptr)$c, (mpz_srcptr)$d);
			]"
		end

	mpz_congruent_ui_p (n: POINTER; c, d: NATURAL_32): INTEGER_32
			-- Return non-zero if `n' is congruent to `c' modulo `d'.
			-- `n' is congruent to `c' mod `d' if there exists an integer q satisfying `n' = `c' + q*`d'.
			-- Unlike the other division functions, `d'=0 is accepted and following the rule it can be seen that `n'
			-- and `c' are considered congruent mod 0 only when exactly equal.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_congruent_ui_p((mpz_srcptr)$n, (unsigned long)$c, (unsigned long)$d);
			]"
		end

	mpz_congruent_2exp_p (n, c: POINTER; b: NATURAL_32): INTEGER_32
			-- Return non-zero if `n' is congruent to `c' modulo 2^`b'.
			-- `n' is congruent to `c' mod 2^`b' if there exists an integer q satisfying `n' = `c' + q*2^`b'.
			-- Unlike the other division functions, 2^`b'=0 is accepted and following the rule it can be seen that `n'
			-- and `c' are considered congruent mod 0 only when exactly equal.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_congruent_2exp_p((mpz_srcptr)$n, (mpz_srcptr)$c, (mp_bitcnt_t)$b);
			]"
		end

feature -- Exponentiation

	mpz_powm (rop, base, exp, mod: POINTER)
			-- Set `rop' to (`base' raised to `exp') modulo `mod'.
			-- Negative `exp' is supported if an inverse `base'^-1 mod `mod' exists
			-- (see `mpz_invert' in Number theoretic functions).
			-- If an inverse doesn't exist then a divide by zero is raised.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_powm((mpz_ptr)$rop, (mpz_srcptr)$base, (mpz_srcptr)$exp, (mpz_srcptr)$mod);
			]"
		end

	mpz_powm_ui (rop, base: POINTER; exp: NATURAL_32; mod: POINTER)
			-- Set `rop' to (`base' raised to `exp') modulo `mod'.
			-- Negative `exp' is supported if an inverse `base'^-1 mod `mod' exists
			-- (see `mpz_invert' in Number theoretic functions).
			-- If an inverse doesn't exist then a divide by zero is raised.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_powm_ui((mpz_ptr)$rop, (mpz_srcptr)$base, (unsigned long int)$exp, (mpz_srcptr)$mod);
			]"
		end

	mpz_powm_sec (rop, base, exp, mod: POINTER)
			-- Set `rop' to (`base' raised to `exp') modulo `mod'.
			-- It is required that `exp' > 0 and that `mod' is odd.
			-- This function is designed to take the same time and have the same cache access patterns for any two same-size arguments,
			-- assuming that function arguments are placed at the same position and that the machine state is identical upon function entry.
			-- This function is intended for cryptographic purposes, where resilience to side-channel attacks is desired.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_powm_sec((mpz_ptr)$rop, (mpz_srcptr)$base, (mpz_srcptr)$exp, (mpz_srcptr)$mod);
			]"
		end

	mpz_pow_ui (rop, base: POINTER; exp: NATURAL_32)
			-- Set `rop' to `base' raised to `exp'.
			-- The case 0^0 yields 1.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_pow_ui((mpz_ptr)$rop, (mpz_srcptr)$base, (unsigned long int)$exp);
			]"
		end

	mpz_ui_pow_ui (rop: POINTER; base, exp: NATURAL_32)
			-- Set `rop' to `base' raised to `exp'.
			-- The case 0^0 yields 1.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_ui_pow_ui((mpz_ptr)$rop, (unsigned long int)$base, (unsigned long int)$exp);
			]"
		end

feature -- Root extraction

	mpz_root (rop, op: POINTER; n: NATURAL_32): INTEGER_32
			-- Set `rop' to the truncated integer part of the `n'th root of `op'.
			-- Return non-zero if the computation was exact, i.e., if `op' is `rop' to the `n'th power.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_root((mpz_ptr)$rop, (mpz_srcptr)$op, (unsigned long int)$n);
			]"
		end

	mpz_rootrem (root, rem, u: POINTER; n: NATURAL_32)
			-- Set `root' to the truncated integer part of the `n'th root of `u'.
			-- Set `rem' to the remainder, `u'?`root'^`n'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_rootrem((mpz_ptr)$root, (mpz_ptr)$rem, (mpz_srcptr)$u, (unsigned long int)$n);
			]"
		end

	mpz_sqrt (rop, op: POINTER)
			-- Set `rop' to the truncated integer part of the square root of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_sqrt((mpz_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpz_sqrtrem (rop1, rop2, op: POINTER)
			-- Set `rop1' to the truncated integer part of the square root of `op', like `mpz_sqrt'.
			-- Set `rop2' to the remainder `op'?`rop1'*`rop1', which will be zero if `op' is a perfect square.
			-- If `rop1' and `rop2' are the same variable, the results are undefined.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_sqrtrem((mpz_ptr)$rop1, (mpz_ptr)$rop2, (mpz_srcptr)$op);
			]"
		end

	mpz_perfect_power (op: POINTER): INTEGER_32
			-- Return non-zero if `op' is a perfect power, i.e., if there exist integers a and b, with b>1,
			-- such that `op' equals a raised to the power b.
			-- Under this definition both 0 and 1 are considered to be perfect powers.
			-- Negative values of `op' are accepted, but of course can only be odd perfect powers.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_perfect_power_p((mpz_srcptr)$op);
			]"
		end

	mpz_perfect_square_p (op: POINTER): INTEGER_32
			-- Return non-zero if `op' is a perfect square, i.e., if the square root of `op' is an integer.
			-- Under this definition both 0 and 1 are considered to be perfect squares.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_perfect_square_p((mpz_srcptr)$op);
			]"
		end

feature -- Number theoretic

	mpz_probab_prime_p (n: POINTER; reps: INTEGER_32): INTEGER_32
			-- Determine whether `n' is prime.
			-- Return 2 if `n' is definitely prime, return 1 if `n' is probably prime (without being certain),
			-- or return 0 if `n' is definitely composite.
			-- This function does some trial divisions, then some Miller-Rabin probabilistic primality tests.
			-- `reps' controls how many such tests are done, 5 to 10 is a reasonable number, more will reduce
			-- the chances of a composite being returned as "probably prime".
			-- Miller-Rabin and similar tests can be more properly called compositeness tests.
			-- Numbers which fail are known to be composite but those which pass might be prime or might be composite.
			-- Only a few composites pass, hence those which pass are considered probably prime.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_probab_prime_p((mpz_srcptr)$n, (int)$reps);
			]"
		end

	mpz_nextprime (rop, op: POINTER)
			-- Set `rop' to the next prime greater than `op'.
			-- This function uses a probabilistic algorithm to identify primes.
			-- For practical purposes it's adequate, the chance of a composite passing will be extremely small.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_nextprime((mpz_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpz_gcd (rop, op1, op2: POINTER)
			-- Set `rop' to the greatest common divisor of `op1' and `op2'.
			-- The result is always positive even if one or both input operands are negative.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_gcd((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_gcd_ui (rop, op1: POINTER; op2: NATURAL_32): NATURAL_32
			-- Compute the greatest common divisor of `op1' and `op2'.
			-- If `rop' is not NULL, store the result there.
			-- If the result is small enough to fit in an unsigned long int, it is returned.
			-- If the result does not fit, 0 is returned, and the result is equal to `op1'.
			-- Note that the result will always fit if `op2' is non-zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_gcd_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_gcdext (g, s, t, a, b: POINTER)
			-- Set `g' to the greatest common divisor of `a' and `b', and in addition set `s' and `t' to coefficients satisfying
			-- `a'*`s' + `b'*`t' = `g'.
			-- The value in `g' is always positive, even if one or both of `a' and `b' are negative.
			-- The values in `s' and `t' are chosen such that abs(`s') <= abs(`b') and abs(`t') <= abs(`a').
			-- If `t' is NULL then that value is not computed.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_gcdext((mpz_ptr)$g, (mpz_ptr)$s, (mpz_ptr)$t, (mpz_srcptr)$a, (mpz_srcptr)$b);
			]"
		end

	mpz_lcm (rop, op1, op2: POINTER)
			-- Set `rop' to the least common multiple of `op1' and `op2'.
			-- `rop' is always positive, irrespective of the signs of `op1' and `op2'.
			-- `rop' will be zero if either `op1' or `op2' is zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_lcm((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_lcm_ui (rop, op1: POINTER; op2: NATURAL_32)
			-- Set `rop' to the least common multiple of `op1' and `op2'.
			-- `rop' is always positive, irrespective of the signs of `op1' and `op2'.
			-- `rop' will be zero if either `op1' or `op2' is zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_lcm_ui((mpz_ptr)$rop, (mpz_srcptr)$op1, (unsigned long)$op2)
			]"
		end

	mpz_invert (rop, op1, op2: POINTER): INTEGER_32
			-- Compute the inverse of `op1' modulo `op2' and put the result in `rop'.
			-- If the inverse exists, the return value is non-zero and `rop' will satisfy 0 <= `rop' < `op2'.
			-- If an inverse doesn't exist the return value is zero and `rop' is undefined.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_invert((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_jacobi (a, b: POINTER): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b').
			-- This is defined only for `b' odd.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_jacobi((mpz_srcptr)$a, (mpz_srcptr)$b);
			]"
		end

	mpz_legendre (a, p: POINTER): INTEGER_32
			-- Calculate the Legendre symbol (`a'/`p').
			-- This is defined only for `p' an odd positive prime, and for such `p' it's identical to the Jacobi symbol.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_legendre((mpz_srcptr)$a, (mpz_srcptr)$p);
			]"
		end

	mpz_kronecker (a, b: POINTER): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a')
			-- when `a' odd, or (`a'/2)=0 when `a' even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical, so `mpz_kronecker_ui' etc can be
			-- used for mixed precision Jacobi symbols too.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_kronecker((mpz_srcptr)$a, (mpz_srcptr)$b);
			]"
		end

	mpz_kronecker_si (a: POINTER; b: INTEGER_32): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a')
			-- when `a' odd, or (`a'/2)=0 when `a' even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical, so `mpz_kronecker_ui' etc can be
			-- used for mixed precision Jacobi symbols too.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_kronecker_si((mpz_srcptr)$a, (long)$b);
			]"
		end

	mpz_kronecker_ui (a: POINTER; b: NATURAL_32): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a')
			-- when `a' odd, or (`a'/2)=0 when `a' even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical, so `mpz_kronecker_ui' etc can be
			-- used for mixed precision Jacobi symbols too.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_kronecker_ui((mpz_srcptr)$a, (unsigned long)$b);
			]"
		end

	mpz_si_kronecker (a: INTEGER_32; b: POINTER): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a')
			-- when `a' odd, or (`a'/2)=0 when `a' even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical, so `mpz_kronecker_ui' etc can be
			-- used for mixed precision Jacobi symbols too.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_si_kronecker((long)$a, (mpz_srcptr)$b);
			]"
		end

	mpz_ui_kronecker (a: NATURAL_32; b: POINTER): INTEGER_32
			-- Calculate the Jacobi symbol (`a'/`b') with the Kronecker extension (`a'/2)=(2/`a')
			-- when `a' odd, or (`a'/2)=0 when `a' even.
			-- When `b' is odd the Jacobi symbol and Kronecker symbol are identical, so `mpz_kronecker_ui' etc can be
			-- used for mixed precision Jacobi symbols too.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_ui_kronecker((unsigned long)$a, (mpz_srcptr)$b);
			]"
		end

	mpz_remove (rop, op, f: POINTER): NATURAL_32
			-- Remove all occurrences of the factor `f' from `op' and store the result in `rop'.
			-- The return value is how many such occurrences were removed.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (unsigned long int)mpz_remove((mpz_ptr)$rop, (mpz_srcptr)$op, (mpz_srcptr)$f);
			]"
		end

	mpz_fac_ui (rop: POINTER; op: NATURAL_32)
			-- Set `rop' to `op'!, the factorial of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fac_ui((mpz_ptr)$rop, (unsigned long int)$op);
			]"
		end

	mpz_bin_ui (rop, n: POINTER; k: NATURAL_32)
			-- Compute the binomial coefficient `n' over `k' and store the result in `rop'.
			-- Negative values of `n' are supported using the identity bin(-`n',`k') = (-1)^`k' * bin(`n'+`k'-1,`k'),
			-- see Knuth volume 1 section 1.2.6 part G.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_bin_ui((mpz_ptr)$rop, (mpz_srcptr)$n, (unsigned long int)$k);
			]"
		end

	mpz_bin_uiui (rop: POINTER; n, k: NATURAL_32)
			-- Compute the binomial coefficient `n' over `k' and store the result in `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_bin_uiui((mpz_ptr)$rop, (unsigned long int)$n, (unsigned long int)$k);
			]"
		end

	mpz_fib_ui (fn: POINTER; n: NATURAL_32)
			-- Sets `fn' to to F[`n'], the `n'th Fibonacci number.
			-- This function is designed for calculating isolated Fibonacci numbers.
			-- When a sequence of values is wanted it's best to start with `mpz_fib2_ui' and iterate
			-- the defining F[`n'+1]=F[`n']+F[`n'-1] or similar.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fib_ui((mpz_ptr)$fn, (unsigned long int)$n);
			]"
		end

	mpz_fib2_ui (fn, fnsub1: POINTER; n: NATURAL_32)
			-- Sets `fn' to F[`n'], and `fnsub1' to F[`n'-1].
			-- This function is designed for calculating isolated Fibonacci numbers.
			-- When a sequence of values is wanted it's best to start with `mpz_fib2_ui' and iterate
			-- the defining F[`n'+1]=F[`n']+F[`n'-1] or similar.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_fib2_ui((mpz_ptr)$fn, (mpz_ptr)$fnsub1, (unsigned long int)$n);
			]"
		end

	mpz_lucnum_ui (ln: POINTER; n: NATURAL_32)
			-- Sets `ln' to to L[`n'], the `n'th Lucas number.
			-- This function is designed for calculating isolated Lucas numbers.
			-- When a sequence of values is wanted it's best to start with `mpz_lucnum2_ui' and iterate
			-- the defining L[`n'+1]=L[`n']+L[`n'-1] or similar.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_lucnum_ui((mpz_ptr)$ln, (unsigned long int)$n);
			]"
		end

	mpz_lucnum2_ui (ln, lnsub1: POINTER; n: NATURAL_32)
			-- Sets `ln' to L[`n'], and `lnsub1' to L[`n'-1].
			-- This function is designed for calculating isolated Lucas numbers.
			-- When a sequence of values is wanted it's best to start with `mpz_lucnum2_ui' and iterate
			-- the defining L[`n'+1]=L[`n']+L[`n'-1] or similar.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_lucnum2_ui((mpz_ptr)$ln, (mpz_ptr)$lnsub1, (unsigned long int)$n);
			]"
		end

feature -- Comparison

	mpz_cmp (op1, op2: POINTER): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmp((mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_cmp_d (op1: POINTER; op2: REAL_64): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
			-- Can be called with an infinity, but results are undefined for a NaN.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmp_d((mpz_srcptr)$op1, (double)$op2);
			]"
		end

	mpz_cmp_si (op1: POINTER; op2: INTEGER_32): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmp_si((mpz_srcptr)$op1, (signed long int)$op2);
			]"
		end

	mpz_cmp_ui (op1: POINTER; op2: NATURAL_32): INTEGER_32
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmp_ui((mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_cmpabs (op1, op2: POINTER): INTEGER_32
			-- Compare the absolute values of `op1' and `op2'.
			-- Return a positive value if abs(`op1') > abs(`op2'), zero if abs(`op1') = abs(`op2'),
			-- or a negative value if abs(`op1') < abs(`op2').
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmpabs((mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_cmpabs_d (op1: POINTER; op2: REAL_64): INTEGER_32
			-- Compare the absolute values of `op1' and `op2'.
			-- Return a positive value if abs(`op1') > abs(`op2'), zero if abs(`op1') = abs(`op2'),
			-- or a negative value if abs(`op1') < abs(`op2').
			-- Can be called with an infinity, but results are undefined for a NaN.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmpabs_d((mpz_srcptr)$op1, (double)$op2);
			]"
		end

	mpz_cmpabs_ui (op1: POINTER; op2: NATURAL_32): INTEGER_32
			-- Compare the absolute values of `op1' and `op2'.
			-- Return a positive value if abs(`op1') > abs(`op2'), zero if abs(`op1') = abs(`op2'),
			-- or a negative value if abs(`op1') < abs(`op2').
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_cmpabs_ui((mpz_srcptr)$op1, (unsigned long int)$op2);
			]"
		end

	mpz_sgn (op: POINTER): INTEGER_32
			-- Return +1 if `op' > 0, 0 if `op' = 0, and -1 if `op' < 0.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_sgn((mpz_srcptr)$op);
			]"
		end

feature -- Logical and bit manipulation

	mpz_and (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' bitwise-and `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_and((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_ior (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' bitwise inclusive-or `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_ior((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_xor (rop, op1, op2: POINTER)
			-- Set `rop' to `op1' bitwise exclusive-or `op2'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_xor((mpz_ptr)$rop, (mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_com (rop, op: POINTER)
			-- Set `rop' to the one's complement of `op'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_com((mpz_ptr)$rop, (mpz_srcptr)$op);
			]"
		end

	mpz_popcount (op: POINTER): NATURAL_32
			-- If `op'>=0, return the population count of `op', which is the number of 1 bits in the binary representation.
			-- If `op'<0, the number of 1s is infinite, and the return value is the largest possible mp_bitcnt_t.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpz_popcount((mpz_srcptr)$op);
			]"
		end

	mpz_hamdist (op1, op2: POINTER): NATURAL_32
			-- If `op1' and `op2' are both >=0 or both <0, return the hamming distance between the two operands,
			-- which is the number of bit positions where `op1' and `op2' have different bit values.
			-- If one operand is >=0 and the other <0 then the number of bits different is infinite, and the return
			-- value is the largest possible mp_bitcnt_t.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpz_hamdist((mpz_srcptr)$op1, (mpz_srcptr)$op2);
			]"
		end

	mpz_scan0 (op: POINTER; starting_bit: NATURAL_32): NATURAL_32
			-- Scan `op', starting from bit `starting_bit', towards more significant bits, until the first 0 or 1 bit (respectively) is found.
			-- Return the index (0 based) of the found bit.
			-- If the bit at `starting_bit' is already what's sought, then `starting_bit' is returned.
			-- If there's no bit found, then the largest possible mp_bitcnt_t is returned.
			-- This will happen past the end of a negative number.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpz_scan0((mpz_srcptr)$op, (mp_bitcnt_t)$starting_bit);
			]"
		end

	mpz_scan1 (op: POINTER; starting_bit: NATURAL_32): NATURAL_32
			-- Scan `op', starting from bit `starting_bit', towards more significant bits, until the first 0 or 1 bit (respectively) is found.
			-- Return the index (0 based) of the found bit.
			-- If the bit at `starting_bit' is already what's sought, then `starting_bit' is returned.
			-- If there's no bit found, then the largest possible mp_bitcnt_t is returned.
			-- This will happen past the end of a nonnegative number.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_bitcnt_t)mpz_scan1((mpz_srcptr)$op, (mp_bitcnt_t)$starting_bit);
			]"
		end

	mpz_setbit (rop: POINTER; bit_index: NATURAL_32)
			-- Set bit `bit_index' in `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_setbit((mpz_ptr)$rop, (mp_bitcnt_t)$bit_index);
			]"
		end

	mpz_clrbit (rop: POINTER; bit_index: NATURAL_32)
			-- Clear bit `bit_index' in `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_clrbit((mpz_ptr)$rop, (mp_bitcnt_t)$bit_index);
			]"
		end

	mpz_combit (rop: POINTER; bit_index: NATURAL_32)
			-- Complement bit `bit_index' in `rop'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_combit((mpz_ptr)$rop, (mp_bitcnt_t)$bit_index);
			]"
		end

	mpz_tstbit (op: POINTER; starting_bit: NATURAL_32): INTEGER_32
			-- Test bit `bit_index' in `op' and return 0 or 1 accordingly.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_tstbit((mpz_srcptr)$op, (mp_bitcnt_t)$starting_bit);
			]"
		end

feature -- Input and output

	mpz_out_str (stream: POINTER; base: INTEGER_32; op: POINTER): NATURAL_64
			-- Output `op' on stdio stream `stream', as a string of digits in base `base'.
			-- `base' may vary from 2 to 62 or from ?2 to ?36.
			-- For `base' in the range 2..36, digits and lower-case letters are used; for ?2..?36, digits
			-- and upper-case letters are used; for 37..62, digits, upper-case letters, and lower-case letters
			-- (in that significance order) are used.
			-- Return the number of bytes written, or if an error occurred, return 0.
			-- Passing a NULL pointer for `stream' will make it write to stdout.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpz_out_str((FILE *)$stream, (int)$base, (mpz_srcptr)$op);
			]"
		end

	mpz_inp_str (rop, stream: POINTER; base: INTEGER_32): NATURAL_64
			-- Input a possibly white-space preceded string in base `base' from stdio stream `stream', and put the read integer in `rop'.
			-- `base' may vary from 2 to 62, or if base is 0, then the leading characters are used: 0x and 0X for hexadecimal, 0b and 0B
			-- for binary, 0 for octal, or decimal otherwise.
			-- For bases up to 36, case is ignored; upper-case and lower-case letters have the same value.
			-- For bases 37 to 62, upper-case letter represent the usual 10..35 while lower-case letter represent 36..61.
			-- Return the number of bytes read, or if an error occurred, return 0.
			-- Passing a NULL pointer for `stream' will make it read from stdin.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpz_inp_str((mpz_ptr)$rop, (FILE *)$stream, (int)$base);
			]"
		end

	mpz_out_raw (stream, op: POINTER): NATURAL_64
			-- Output `op' on stdio stream `stream', in raw binary format.
			-- The integer is written in a portable format, with 4 bytes of size information, and that many bytes of limbs.
			-- Both the size and the limbs are written in decreasing significance order (i.e., in big-endian).
			-- The output can be read with `mpz_inp_raw'.
			-- Return the number of bytes written, or if an error occurred, return 0.
			-- The output of this can not be read by mpz_inp_raw from GMP 1, because of changes necessary for compatibility
			-- between 32-bit and 64-bit machines.
			-- Passing a NULL pointer for `stream' will make it write to stdout.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpz_out_raw((FILE *)$stream, (mpz_srcptr)$op);
			]"
		end

	mpz_inp_raw (rop, stream: POINTER): NATURAL_64
			-- Input from stdio stream `stream' in the format written by `mpz_out_raw', and put the result in `rop'.
			-- Return the number of bytes read, or if an error occurred, return 0.
			-- This routine can read the output from `mpz_out_raw' also from GMP 1, in spite of changes necessary for compatibility
			-- between 32-bit and 64-bit machines.
			-- Passing a NULL pointer for `stream' will make it read from stdin.
		external
			"C inline use <stdio.h>, %"gmp.h%""
		alias
			"[
				return (size_t)mpz_inp_raw((mpz_ptr)$rop, (FILE *)$stream);
			]"
		end

feature -- Random number

	mpz_urandomb (rop, state: POINTER; n: NATURAL_32)
			-- Generate a uniformly distributed random integer in the range 0 to 2^`n'-1, inclusive.
			-- `state' must be initialized by calling one of the gmp_randinit functions (see class RANDOM_STATE_INITIALIZATION)
			-- before invoking this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_urandomb((mpz_ptr)$rop, (__gmp_randstate_struct *)$state, (mp_bitcnt_t)$n);
			]"
		end

	mpz_urandomm (rop, state: POINTER; n: NATURAL_32)
			-- Generate a uniform random integer in the range 0 to `n'-1, inclusive.
			-- `state' must be initialized by calling one of the gmp_randinit functions (see class RANDOM_STATE_INITIALIZATION)
			-- before invoking this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_urandomm((mpz_ptr)$rop, (__gmp_randstate_struct *)$state, (mp_bitcnt_t)$n);
			]"
		end

	mpz_rrandomb (rop, state: POINTER; n: NATURAL_32)
			-- Generate a random integer with long strings of zeros and ones in the binary representation.
			-- Useful for testing functions and algorithms, since this kind of random numbers have proven to be more likely to
			-- trigger corner-case bugs.
			-- The random number will be in the range 0 to 2^`n'-1, inclusive.
			-- `state' must be initialized by calling one of the gmp_randinit functions (see class RANDOM_STATE_INITIALIZATION)
			-- before invoking this function.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_rrandomb((mpz_ptr)$rop, (__gmp_randstate_struct *)$state, (mp_bitcnt_t)$n);
			]"
		end

feature -- Import and export

	mpz_import (rop: POINTER; count: NATURAL_64; order: INTEGER_32; size: NATURAL_64; endian: INTEGER_32; nails: NATURAL_64; op: POINTER)
			-- Set `rop' from an array of word data at `op'.
			-- The parameters specify the format of the data. `count' many words are read, each `size' bytes. order can be 1 for most
			-- significant word first or -1 for least significant first.
			-- Within each word `endian' can be 1 for most significant byte first, -1 for least significant first, or 0 for the native
			-- endianness of the host CPU.
			-- The most significant `nails' bits of each word are skipped, this can be 0 to use the full words.
			-- There is no sign taken from the data, `rop' will simply be a positive integer.
			-- An application can handle any sign itself, and apply it for instance with `mpz_neg'.
			-- There are no data alignment restrictions on `op', any address is allowed.
			-- Here's an example converting an array of unsigned long data, most significant element first, and host byte order within each value.
			--		unsigned long  a[20];
			--		/* Initialize z and a */
			--		mpz_import (z, 20, 1, sizeof(a[0]), 0, 0, a);
			-- This example assumes the full sizeof bytes are used for data in the given type, which is usually true, and certainly true for
			-- unsigned long everywhere we know of.
			-- However on Cray vector systems it may be noted that short and int are always stored in 8 bytes (and with sizeof indicating that)
			-- but use only 32 or 46 bits.
			-- The `nails' feature can account for this, by passing for instance 8*sizeof(int)-INT_BIT.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_import((mpz_ptr)$rop, (size_t)$count, (int)$order, (size_t)$size, (int)$endian, (size_t)$nails, (const void *)$op);
			]"
		end

	mpz_export (rop: POINTER; countp: TYPED_POINTER [NATURAL_64]; order: INTEGER_32;
				size: NATURAL_64; endian: INTEGER_32; nails: NATURAL_64; op: POINTER): POINTER
			-- Fill `rop' with word data from `op'.
			-- The parameters specify the format of the data produced.
			-- Each word will be `size' bytes and `order' can be 1 for most significant word first or -1 for least significant first.
			-- Within each word `endian' can be 1 for most significant byte first, -1 for least significant first, or 0 for the native
			-- endianness of the host CPU.
			-- The most significant `nails' bits of each word are unused and set to zero, this can be 0 to produce full words.
			-- The number of words produced is written to *`countp', or `countp' can be NULL to discard the count.
			-- `rop' must have enough space for the data, or if `rop' is NULL then a result array of the necessary size is allocated
			-- using the current GMP allocation function.
			-- In either case the return value is the destination used, either `rop' or the allocated block.
			-- If `op' is non-zero then the most significant word produced will be non-zero.
			-- If `op' is zero then the count returned will be zero and nothing written to `rop'.
			-- If `rop' is NULL in this case, no block is allocated, just NULL is returned.
			-- The sign of `op' is ignored, just the absolute value is exported.
			-- An application can use `mpz_sgn' to get the sign and handle it as desired. (see Comparison)
			-- There are no data alignment restrictions on `rop', any address is allowed.
			-- When an application is allocating space itself the required size can be determined with a calculation like the following.
			-- Since `mpz_sizeinbase' always returns at least 1, count here will be at least one, which avoids any portability problems
			-- with malloc(0), though if z is zero no space at all is actually needed (or written).
			--		numb = 8*size - nail;
			--		count = (mpz_sizeinbase (z, 2) + numb-1) / numb;
			--		p = malloc (count * size);
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (void *)mpz_export((void *)$rop, (size_t *)$countp, (int)$order, (size_t)$size, (int)$endian, (size_t)$nails, (mpz_srcptr)$op);
			]"
		end

feature -- Miscellaneous

	mpz_fits_ulong_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in an unsigned long int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_ulong_p((mpz_srcptr)$op);
			]"
		end

	mpz_fits_slong_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in a signed long int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_slong_p((mpz_srcptr)$op);
			]"
		end

	mpz_fits_uint_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in an unsigned int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_uint_p((mpz_srcptr)$op);
			]"
		end

	mpz_fits_sint_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in a signed int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_sint_p((mpz_srcptr)$op);
			]"
		end

	mpz_fits_ushort_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in an unsigned short int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_ushort_p((mpz_srcptr)$op);
			]"
		end

	mpz_fits_sshort_p (op: POINTER): INTEGER_32
			-- Return non-zero iff the value of `op' fits in a signed short int.
			-- Otherwise, return zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_fits_sshort_p((mpz_srcptr)$op);
			]"
		end

	mpz_odd_p (op: POINTER): INTEGER_32
			-- Determine whether `op' is odd.
			-- Return non-zero if yes, zero if no.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_odd_p((mpz_srcptr)$op);
			]"
		end

	mpz_even_p (op: POINTER): INTEGER_32
			-- Determine whether `op' even.
			-- Return non-zero if yes, zero if no.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mpz_even_p((mpz_srcptr)$op);
			]"
		end

	mpz_sizeinbase (op: POINTER; base: INTEGER_32): NATURAL_64
			-- Return the size of `op' measured in number of digits in the given base.
			-- `base' can vary from 2 to 62.
			-- The sign of `op' is ignored, just the absolute value is used.
			-- The result will be either exact or 1 too big.
			-- If `base' is a power of 2, the result is always exact.
			-- If `op' is zero the return value is always 1.
			-- This function can be used to determine the space required when converting `op' to a string.
			-- The right amount of allocation is normally two more than the value returned by `mpz_sizeinbase', one extra for
			-- a minus sign and one for the null-terminator.
			-- It will be noted that `mpz_sizeinbase'(`op',2) can be used to locate the most significant 1 bit in `op', counting from 1.
			-- (Unlike the bitwise functions which start from 0, See Logical and bit manipulation.)
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (size_t)mpz_sizeinbase((mpz_srcptr)$op, (int)$base);
			]"
		end

feature -- Special

	mpz_array_init (integer_array: POINTER; array_size, fixed_num_bits: INTEGER_32)
			-- This is a special type of initialization.
			-- Fixed space of `fixed_num_bits' is allocated to each of the `array_size' integers in `integer_array'.
			-- There is no way to free the storage allocated by this function.
			-- Don't call `mpz_clear'!
			-- The `integer_array' parameter is the first mpz_t in the array. For example,
			--		mpz_t  arr[20000];
			--		mpz_array_init (arr[0], 20000, 512);
			-- This function is only intended for programs that create a large number of integers and need to reduce
			-- memory usage by avoiding the overheads of allocating and reallocating lots of small blocks.
			-- In normal programs this function is not recommended.
			-- The space allocated to each integer by this function will not be automatically increased, unlike the normal
			-- `mpz_init', so an application must ensure it is sufficient for any value stored. The following space requirements
			-- apply to various routines,
			--		`mpz_abs', `mpz_neg', `mpz_set', `mpz_set_si' and `mpz_set_ui' need room for the value they store.
			--		`mpz_add', `mpz_add_ui', `mpz_sub' and `mpz_sub_ui' need room for the larger of the two operands, plus an extra
			--		`mp_bits_per_limb' (see class GMP_CONSTANTS).
			--		`mpz_mul', `mpz_mul_ui' and `mpz_mul_ui' need room for the sum of the number of bits in their operands, but each rounded
			--		up to a multiple of `mp_bits_per_limb' (see class GMP_CONSTANTS).
			--		`mpz_swap' can be used between two array variables, but not between an array and a normal variable.
			-- For other functions, or if in doubt, the suggestion is to calculate in a regular `mpz_init' variable and copy the result to
			-- an array variable with `mpz_set'.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				mpz_array_init((mpz_ptr)$integer_array, (mp_size_t)$array_size, (mp_size_t)$fixed_num_bits);
			]"
		end

	mpz_realloc (integer: POINTER; new_alloc: INTEGER_32): POINTER
			-- Change the space for `integer' to `new_alloc' limbs.
			-- The value in `integer' is preserved if it fits, or is set to 0 if not.
			-- The return value is not useful to applications and should be ignored.
			-- `mpz_realloc2' is the preferred way to accomplish allocation changes like this.
			-- `mpz_realloc2' and `mpz_realloc' are the same except that `mpz_realloc' takes its size in limbs.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (void *)_mpz_realloc((mpz_ptr)$integer, (mp_size_t)$new_alloc);
			]"
		end

	mpz_getlimbn (op: POINTER; n: INTEGER_32): NATURAL_64
			-- Return limb number `n' from `op'.
			-- The sign of `op' is ignored, just the absolute value is used.
			-- The least significant limb is number 0.
			-- `mpz_size' can be used to find how many limbs make up `op'.
			-- `mpz_getlimbn' returns zero if `n' is outside the range 0 to `mpz_size'(`op')-1.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_limb_t)mpz_getlimbn((mpz_srcptr)$op, (mp_size_t)$n);
			]"
		end

	mpz_size (op: POINTER): NATURAL_64
			-- Return the size of `op' measured in number of limbs.
			-- If `op' is zero, the returned value will be zero.
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (mp_limb_t)mpz_size((mpz_srcptr)$op);
			]"
		end

end
