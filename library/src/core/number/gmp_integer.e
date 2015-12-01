note

	description: "Arbitrary precision integer"

	author: "Chris Saunders; Colin Adams"
	date: "$Date:  $"
	revision: "$Revision:  $"

class GMP_INTEGER

inherit

	COMPARABLE
		undefine
			default_create
		redefine
			copy,
			is_equal,
			out
		end

	DEBUG_OUTPUT
		rename
			debug_output as out
		undefine
			default_create
		redefine
			copy,
			is_equal,
			out
		end

	MPZ_STRUCT
		export
			{NONE} all
			{ANY} item
		redefine
			copy,
			is_equal,
			out
		end

	NUMERIC
		rename
			quotient as integer_quotient alias "//"
		undefine
			default_create
		redefine
			copy,
			is_equal,
			out
		end

create

	default_create,
	make_by_pointer,
	make_integer_32,
	make_gmp_float,
	make_gmp_rational,
	make_natural_32,
	make_real_64,
	make_string

feature {NONE} -- Initialization

	make_integer_32 (v: INTEGER_32)
			-- Initialize from `v'.
		do
			default_create
			set_integer_32 (v)
		end

	make_gmp_float (v: GMP_FLOAT)
			-- Initialize from `v'.
		require
			v_attached: v /= Void
		do
			default_create
			set_gmp_float (v)
		end

	make_gmp_rational (v: GMP_RATIONAL)
			-- Initialize from truncation of `v' to an integer.
		require
			v_attached: v /= Void
		do
			default_create
			set_gmp_rational (v)
		end

	make_natural_32 (v: NATURAL_32)
			-- Initialize from `v'.
		do
			default_create
			set_natural_32 (v)
		end

	make_real_64 (v: REAL_64)
			-- Initialize from `v'.
			-- `v' will be truncated.
		do
			default_create
			set_real_64 (v)
		end

	make_string (v: STRING)
			-- Initialize from `v'.
			-- `v' is assumed to be a decimal string.
		require
			v_attached: v /= Void
			v_is_decimal_integer_string: is_decimal_integer_string (v)
		do
			default_create
			set_string (v)
		end

	make_binary_string (v: STRING)
			-- Initialize from `v'.
			-- `v' is assumed to be a binary format string.
		require
			v_attached: v /= Void
			v_is_binary_integer_string: is_binary_integer_string (v)
		do
			default_create
			set_binary_string (v)
		end

	make_hex_string (v: STRING)
			-- Initialize from `v'.
			-- `v' is assumed to be a hexadecimal format string.
		require
			v_attached: v /= Void
			v_is_hex_integer_string: is_hex_integer_string (v)
		do
			default_create
			set_hex_string (v)
		end

feature -- Access

	sign: INTEGER_32
			-- Sign value (0, -1 or 1)
		do
			Result := {MPZ_FUNCTIONS}.mpz_sgn  (item)
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_set_si (Result.item, 1)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result
		end

feature -- Measurement

	Probably_prime_repetitions: INTEGER_32 = 20
			-- Number of repetitions for `is_probably_prime'.

	precision: NATURAL_32
			-- Current precision in bits.
		do
			Result := {MPZ_FUNCTIONS}.mpz_sizeinbase (item, 2).to_natural_32
		end

feature -- Status report

	divisible (a_other: like Current): BOOLEAN
			-- May `Current' be divided by `a_other'?
		do
			Result := {MPZ_FUNCTIONS}.mpz_cmp (a_other.item, Zero.item) /= 0
		end

	fits_integer_32: BOOLEAN
			-- Does `Current' fit an INTEGER_32?
		do
			Result := {MPZ_FUNCTIONS}.mpz_fits_slong_p (item) /= 0
		end

	fits_natural_32: BOOLEAN
			-- Does `Current' fit a NATURAL_32?
		do
			Result := {MPZ_FUNCTIONS}.mpz_fits_ulong_p (item) /= 0
		end

	is_even: BOOLEAN
			-- Is `Current' an even number?
		do
			Result := {MPZ_FUNCTIONS}.mpz_even_p (item) /= 0
		end

	is_binary_integer_string (v: STRING): BOOLEAN
			-- Is `v' a string that can represent a binary integer?
		require
			v_attached: v /= Void
		local
			i, l_count: INTEGER
			c: CHARACTER
			l_str: STRING
		do
			if not v.is_empty then
				if v.item (1) = '-' or else v.item (1) = '+' then
					l_str := v.substring (2, v.count)
				else
					l_str := v
				end
				from
					i := 1
					Result := True
					l_count := l_str.count
				until
					(not Result) or else (i > l_count)
				loop
					c := l_str.item (i)
					Result := c = '0' or else c = '1'
					i := i + 1
				end
			end
		end

	is_decimal_integer_string (v: STRING): BOOLEAN
			-- Is `v' a string that can represent a decimal integer?
		require
			v_attached: v /= Void
		local
			i, l_count: INTEGER
			l_str: STRING
		do
			if not v.is_empty then
				if v.item (1) = '-' or else v.item (1) = '+' then
					l_str := v.substring (2, v.count)
				else
					l_str := v
				end
				from
					i := 1
					Result := True
					l_count := l_str.count
				until
					(not Result) or else (i > l_count)
				loop
					Result := l_str.item (i).is_digit
					i := i + 1
				end
			end
		end

	is_hex_integer_string (v: STRING): BOOLEAN
			-- Is `v' a string that can represent a hexadecimal integer?
		require
			v_attached: v /= Void
		local
			i, l_count: INTEGER
			l_str: STRING
		do
			if not v.is_empty then
				if v.item (1) = '-' or else v.item (1) = '+' then
					l_str := v.substring (2, v.count)
				else
					l_str := v
				end
				from
					i := 1
					Result := True
					l_count := l_str.count
				until
					(not Result) or else (i > l_count)
				loop
					Result := l_str.item (i).is_hexa_digit
					i := i + 1
				end
			end
		end

	is_zero: BOOLEAN
			-- Is `Current' zero?
		do
			Result := (Current ~ zero)
		end

	is_odd: BOOLEAN
			-- Is `Current' an odd number?
		do
			Result := {MPZ_FUNCTIONS}.mpz_odd_p (item) /= 0
		end

	is_prime: BOOLEAN
			-- Is `Current' prime?
		do
			Result := {MPZ_FUNCTIONS}.mpz_probab_prime_p (item, Probably_prime_repetitions) = 2
		end

	is_probably_prime: BOOLEAN
			-- Is `Current' probably prime?
		do
			Result := {MPZ_FUNCTIONS}.mpz_probab_prime_p (item, Probably_prime_repetitions) = 1
		end

	set_string_successful: BOOLEAN
			-- Was the last call to `set_string' successful?

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' attached to an object of the same type
			-- as `Current' and identical to it?
		do
			Result := {MPZ_FUNCTIONS}.mpz_cmp (item, a_other.item) = 0
		end

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- Is `Current' less than `a_other'?
		do
			Result := {MPZ_FUNCTIONS}.mpz_cmp (item, a_other.item) < 0
		end

feature -- Element change

	set_integer_32 (v: INTEGER_32)
			-- Set `Current' from `v'.
		do
			{MPZ_FUNCTIONS}.mpz_set_si (item, v)
		end

	set_gmp_float (v: GMP_FLOAT)
			-- Set `Current' from `v'.
		require
			v_attached: v /= Void
		do
			{MPZ_FUNCTIONS}.mpz_set_f (item, v.item)
		end

	set_gmp_rational (v: GMP_RATIONAL)
			-- Set `Current' from truncation of `v' to an integer.
		require
			v_attached: v /= Void
		do
			{MPZ_FUNCTIONS}.mpz_set_q (item, v.item)
		end

	set_natural_32 (v: NATURAL_32)
			-- Set `Current' from `v'.
		do
			{MPZ_FUNCTIONS}.mpz_set_ui (item, v)
		end

	set_real_64 (v: REAL_64)
			-- Set `Current' from `v'.
			-- `v' will be truncated.
		do
			{MPZ_FUNCTIONS}.mpz_set_d (item, v)
		end

	set_string (v: STRING)
			-- Set `Current' from `v'.
			-- `v' is assumed to be a decimal string.
		require
			v_attached: v /= Void
			v_is_decimal_integer_string: is_decimal_integer_string (v)
		do
			set_string_successful := {MPZ_FUNCTIONS}.mpz_set_str (item, (create {C_STRING}.make (v)).item, Decimal) = 0
		ensure
			set_string_successful: set_string_successful
		end

	set_binary_string (v: STRING)
			-- Set `Current' from `v'.
			-- `v' is assumed to be a binary format string.
		require
			v_attached: v /= Void
			v_is_binary_integer_string: is_binary_integer_string (v)
		do
			set_string_successful := {MPZ_FUNCTIONS}.mpz_set_str (item, (create {C_STRING}.make (v)).item, Binary) = 0
		ensure
			set_string_successful: set_string_successful
		end

	set_hex_string (v: STRING)
			-- Set `Current' from `v'.
			-- `v' is assumed to be a hexadecimal format string.
		require
			v_attached: v /= Void
			v_is_hex_integer_string: is_hex_integer_string (v)
		do
			set_string_successful := {MPZ_FUNCTIONS}.mpz_set_str (item, (create {C_STRING}.make (v)).item, Hexadecimal) = 0
		ensure
			set_string_successful: set_string_successful
		end

feature -- Conversion

	as_integer_32: INTEGER_32
			-- Conversion to an INTEGER_32
		do
			Result := {MPZ_FUNCTIONS}.mpz_get_si (item)
		end

	as_natural_32: NATURAL_32
			-- Conversion to a NATURAL_32
		do
			Result := {MPZ_FUNCTIONS}.mpz_get_ui (item)
		end

	to_integer_32: INTEGER_32
			-- Conversion to an INTEGER_32
		require
			fits_integer_32: fits_integer_32
		do
			Result := as_integer_32
		end

	to_natural_32: NATURAL_32
			-- Conversion to a NATURAL_32
		require
			fits_natural_32: fits_natural_32
		do
			Result := as_natural_32
		end

	to_binary_string: STRING
			-- Conversion to a binary string
		do
			Result := (create {C_STRING}.make_by_pointer ({MPZ_FUNCTIONS}.mpz_get_str (default_pointer, Binary, item))).string
		ensure
			to_binary_string_attached: Result /= Void
		end

	to_hex_string: STRING
			-- Conversion to a binary string
		do
			Result := (create {C_STRING}.make_by_pointer ({MPZ_FUNCTIONS}.mpz_get_str (default_pointer, Hexadecimal, item))).string
		ensure
			to_hex_string_attached: Result /= Void
		end

	to_gmp_float: GMP_FLOAT
			-- Conversion to a real number
		do
			create Result.make_gmp_integer (Current)
		ensure
			to_gmp_float_attached: Result /= Void
		end

	to_gmp_rational: GMP_RATIONAL
			-- Conversion to a rational number
		do
			create Result.make_gmp_integer (Current)
		ensure
			to_gmp_rational_attached: Result /= Void
		end

	to_real_64: REAL_64
			-- Conversion to a REAL_64
		do
			Result := {MPZ_FUNCTIONS}.mpz_get_d (item)
		end

feature -- Duplication

	copy (a_other: like Current)
			-- Update `Current' using fields of object attached
			-- to `a_other', so as to yield equal objects.
		do
			if item = default_pointer then
				default_create
			end
			{MPZ_FUNCTIONS}.mpz_set (item, a_other.item)
		end

feature -- Basic operations

	abs: like Current
			-- Absolute value of `Current'
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_abs (Result.item, item)
		ensure
			non_negative: Result >= zero
			same_absolute_value: (Result ~ Current) or (Result ~ -Current)
		end

	plus alias "+" (a_other: like Current): like Current
			-- Sum of `Current' with `a_other' (commutative)
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_add (Result.item, item, a_other.item)
		end

	minus alias "-" (a_other: like Current): like Current
			-- Subtraction of `a_other' from `Current'
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_sub (Result.item, item, a_other.item)
		end

	product alias "*" (a_other: like Current): like Current
			-- Product of `Current' with `a_other'
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_mul (Result.item, item, a_other.item)
		end

	integer_quotient alias "//" (a_other: like Current): like Current
			-- Division of `Current' by `a_other'
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_tdiv_q (Result.item, item, a_other.item)
		end

	integer_remainder alias "\\" (a_other: like Current): like Current
			-- Remainder of integer division of Current by `a_other'
		require
			a_other_attached: a_other /= Void
			good_divisor: divisible (a_other)
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_mod (Result.item, item, a_other.item)
		end

	quotient alias "/" (a_other: like Current): GMP_FLOAT
			-- Division by `a_other'
		require
			a_other_attached: a_other /= Void
			good_divisor: divisible (a_other)
		local
			l_mpf_current, l_mpf_other: GMP_FLOAT
		do
			create l_mpf_current.make_gmp_integer (Current)
			create l_mpf_other.make_gmp_integer (a_other)
			create Result.make_precision (precision.max (a_other.precision))
			{MPF_FUNCTIONS}.mpf_div (Result.item, l_mpf_current.item, l_mpf_other.item)
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_set (Result.item, item)
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_neg (Result.item, item)
		end

feature -- Bit operations

	bit_and alias "&" (a_other: like Current): like Current
			-- Bitwise and between `Current' and `a_other'
		require
			a_other_attached: a_other /= Void
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_and (Result.item, item, a_other.item)
		ensure
			bit_and_attached: Result /= Void
		end

	bit_or alias "|" (a_other: like Current): like Current
			-- Bitwise or between `Current' and `a_other'
		require
			a_other_attached: a_other /= Void
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_ior (Result.item, item, a_other.item)
		ensure
			bit_or_attached: Result /= Void
		end

	bit_xor (a_other: like Current): like Current
			-- Bitwise xor between `Current' and `a_other'
		require
			a_other_attached: a_other /= Void
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_xor (Result.item, item, a_other.item)
		ensure
			bit_xor_attached: Result /= Void
		end

	bit_not: like Current
			-- One's complement of `Current'
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_com (Result.item, item)
		ensure
			bit_not_attached: Result /= Void
		end

	bit_shift (n: INTEGER): like Current
			-- Shift copy of `Current' `n' bits to right if `n' positive,
			-- to left otherwise.
		do
			if n > 0 then
				Result := bit_shift_right (n)
			else
				Result := bit_shift_left (-n)
			end
		ensure
			bit_shift_attached: Result /= Void
		end

	bit_shift_left alias "|<<" (n: INTEGER): like Current
			-- Shift copy of `Current' `n' bits to left
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_mul_2exp (Result.item, item, n.to_natural_32)
		ensure
			bit_shift_left_attached: Result /= Void
		end

	bit_shift_right alias "|>>" (n: INTEGER): like Current
			-- Shift copy of `Current' `n' bits to right.
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_tdiv_q_2exp (Result.item, item, n.to_natural_32)
		ensure
			bit_right_attached: Result /= Void
		end

	bit_test (n: INTEGER): BOOLEAN
			-- Test `n'-th bit of Current.
		do
			Result := {MPZ_FUNCTIONS}.mpz_tstbit (item, n.to_natural_32).to_boolean
		end

	bit_set (b: BOOLEAN; n: INTEGER): like Current
			-- Copy of `Current' with `n'-th bit
			-- set to 1 if `b', 0 otherwise
		do
			create Result
			{MPZ_FUNCTIONS}.mpz_set (Result.item, item)
			if b then
				{MPZ_FUNCTIONS}.mpz_setbit (Result.item, n.to_natural_32)
			else
				{MPZ_FUNCTIONS}.mpz_clrbit (Result.item, n.to_natural_32)
			end
		ensure
			bit_set_attached: Result /= Void
		end

	bit_set_with_mask (b: BOOLEAN; m: like Current): like Current
			-- Copy of `Current' with all 1 bits of `m' set to 1
			-- if `b', 0 otherwise
		require
			m_attached: m /= Void
		local
			l_m_not: like Current
		do
			create Result
			if b then
				{MPZ_FUNCTIONS}.mpz_ior (Result.item, item, m.item)
			else
				create l_m_not
				{MPZ_FUNCTIONS}.mpz_com (l_m_not.item, m.item)
				{MPZ_FUNCTIONS}.mpz_and (Result.item, item, l_m_not.item)
			end
		ensure
			bit_set_with_mask_attached: Result /= Void
		end

feature -- Output

	out: STRING
			-- New string containing terse printable representation
			-- of `Current'
		do
			Result := (create {C_STRING}.make_by_pointer ({MPZ_FUNCTIONS}.mpz_get_str (default_pointer, Decimal, item))).string
		end

feature {NONE} -- Obsolete

	exponentiable (a_other: NUMERIC): BOOLEAN
			-- May `Current' be elevated to the power `a_other'?
		obsolete
			"[2008_04_01] Will be removed since not used."
		do
		end

feature {NONE} -- Implementation

	Binary: INTEGER = 2
			-- Binary base

	Decimal: INTEGER = 10
			-- Decimal base

	Hexadecimal: INTEGER = 16
			-- Hexadecimal base

end
