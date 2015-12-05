note

	description: "Floating point numbers"

	author: "Chris Saunders; Colin Adams"
	date: "$Date: $"
	revision: "$Revision:  $"

class GMP_FLOAT

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

	MPF_STRUCT
		export
			{NONE} all
			{ANY} item
		redefine
			copy,
			is_equal,
			out
		end

	NUMERIC
		undefine
			default_create
		redefine
			copy,
			is_equal,
			out
		end

create
	
	default_create,
	make_integer_32,
	make_integer_32_with_precision,
	make_gmp_rational,
	make_gmp_rational_with_precision,
	make_gmp_integer,
	make_gmp_integer_with_precision,
	make_natural_32,
	make_natural_32_with_precision,
	make_real_64,
	make_real_64_with_precision,
	make_string,
	make_string_with_precision,
	make_precision

feature {NONE} -- Initialization

	make_integer_32 (v: INTEGER_32)
			-- Initialize from `v'.
			-- `precision' will be the default precision.
		do
			default_create
			set_integer_32 (v)
		end

	make_integer_32_with_precision (v: INTEGER_32; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `a_prec'.
		require
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			make_precision (a_prec)
			set_integer_32 (v)
		end

	make_gmp_rational (v: GMP_RATIONAL)
			-- Initialize from `v'.
			-- `precision' will be the default precision.
		require
			v_attached: v /= Void	
		do
			default_create
			set_gmp_rational (v)
		end

	make_gmp_rational_with_precision (v: GMP_RATIONAL; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `prec'.
		require
			v_attached: v /= Void
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)			
		do
			make_precision (a_prec)
			{MPF_FUNCTIONS}.mpf_set_q (item, v.item)
		end

	make_gmp_integer (v: GMP_INTEGER)
			-- Initialize from `v'.
			-- `precision' will be the default precision.
		require
			v_attached: v /= Void
		do
			default_create
			set_gmp_integer (v)
		end

	make_gmp_integer_with_precision (v: GMP_INTEGER; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `a_prec'.
		require
			v_attached: v /= Void
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			make_precision (a_prec)
			{MPF_FUNCTIONS}.mpf_set_z (item, v.item)
		end

	make_natural_32 (v: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be the default precision.
		do
			default_create
			set_natural_32 (v)
		end

	make_natural_32_with_precision (v: NATURAL_32; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `prec'.
		require
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)	
		do
			make_precision (a_prec)
			set_natural_32 (v)
		end

	make_real_64 (v: REAL_64)
			-- Initialize from `v'.
			-- `precision' will be >= `{PLATFORM}.real_64_bits.to_natural_32'.
		do
			make_precision ({PLATFORM}.real_64_bits.to_natural_32)
			set_real_64 (v)
		end

	make_real_64_with_precision (v: REAL_64; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `a_prec'.
		require
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			make_precision (a_prec)
			{MPF_FUNCTIONS}.mpf_set_d (item, v)
		end

	make_string (v: STRING)
			-- Initialize from `v'.
			-- `precision' will be set to a reasonable value.
		require
			v_attached: v /= Void
			v_is_decimal: is_decimal_string (v)
		do
			default_create
			set_string (v)
		ensure
-- NOTE:  I have been unable to determine why `mpf_set_str' is returning -1 if `str' or `v' is some form of zero (0, 0.0, 00.0, 0.00...)
-- If you are attempting to find the source of this problem then have a look at the documentation for `mpf_set_str' in class MPF_FUNCTIONS.
-- Class MPFR has a similar problem.
			set_string_successful: (not is_zero) implies set_string_successful
		end

	make_string_with_precision (v: STRING; a_prec: NATURAL_32)
			-- Initialize from `v'.
			-- `precision' will be >= `a_prec'.
		require
			v_attached: v /= Void
			v_is_decimal: is_decimal_string (v)
		local
			str: STRING
		do
			make_precision (a_prec)
			str := v.twin
			str.prune_all_leading ('0')
			if str.has ('.') then
				str.prune_all_trailing ('0')
			end
			if str ~ "." then
				str := "0.0"
			end
			set_string_successful := {MPF_FUNCTIONS}.mpf_set_str (item, (create {C_STRING}.make (str)).item, Decimal) = 0
		ensure
-- NOTE:  I have been unable to determine why `mpf_set_str' is returning -1 if `str' or `v' is some form of zero (0, 0.0, 00.0, 0.00...)
-- If you are attempting to find the source of this problem then have a look at the documentation for `mpf_set_str' in class MPF_FUNCTIONS.
-- Class MPFR has a similar problem.
			set_string_successful: (not is_zero) implies set_string_successful
		end

feature -- Access

	fraction: GMP_FLOAT
			-- Fractional part of `Current'.
		local
			l_decimal_index: INTEGER_32
			l_fraction_part: STRING
		do
			l_fraction_part := out
			l_decimal_index := l_fraction_part.index_of ('.', 1)
			if l_decimal_index /= 0 then
				l_fraction_part := l_fraction_part.substring (l_decimal_index + 1, l_fraction_part.count)
				l_fraction_part.prepend_string ("0.")
				create Result.make_string (l_fraction_part)
			else
				create Result
			end
		ensure
			fraction_attached: fraction /= Void
		end

	sign: INTEGER_32
			-- Sign value (0, -1 or 1)
		do
			Result := {MPF_FUNCTIONS}.mpf_sgn  (item)
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	one: like Current
			-- Neutral element for "*" and "/"
		do
			create Result
			{MPF_FUNCTIONS}.mpf_set_si (Result.item, 1)
		end

	zero: like Current
			-- Neutral element for "+" and "-"
		do
			create Result
		end

feature -- Measurement

	precision: NATURAL_32
			-- Current precision in bits
		do
			Result := {MPF_FUNCTIONS}.mpf_get_prec (item)
		end

feature -- Status report

	divisible (a_other: like Current): BOOLEAN
			-- May `Current' be divided by `a_other'?
		do
			Result := {MPF_FUNCTIONS}.mpf_cmp_si (a_other.item, 0) /= 0
		end

	fits_integer_32: BOOLEAN
			-- Does `Current' fit an INTEGER_32?
		do
			Result := {MPF_FUNCTIONS}.mpf_fits_slong_p (item) /= 0
		end

	fits_natural_32: BOOLEAN
			-- Does `Current' fit a NATURAL_32?
		do
			Result := {MPF_FUNCTIONS}.mpf_fits_ulong_p (item) /= 0
		end

	is_integer: BOOLEAN
			-- Is `Current' an integer (fractional part = 0)?
		do
			Result := {MPF_FUNCTIONS}.mpf_integer_p (item) /= 0
		end

	is_decimal_string (v: STRING): BOOLEAN
			-- Is `v' a string that can represent a decimal_number?
		require
			v_attached: v /= Void
		local
			i, l_count: INTEGER
			l_str: STRING
			l_point_seen: BOOLEAN
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
					Result := l_str.item (i).is_digit or (l_str.item (i) ~ '.' and not l_point_seen)
					if l_str.item (i)  ~ '.' then
						l_point_seen := True
					end
					i := i + 1
				end
			end
		end

	set_string_successful: BOOLEAN
			-- Was the last call to `set_string' successful?

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' attached to an object of the same type
			-- as `Current' and identical to it?
		do
			Result := {MPF_FUNCTIONS}.mpf_cmp (item, a_other.item) = 0
		end

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- Is `Current' less than `a_other'?
		do
			Result := {MPF_FUNCTIONS}.mpf_cmp (item, a_other.item) < 0
		end

feature -- Element change

	set_integer_32 (v: INTEGER_32)
			-- Set from `v'.
		do
			{MPF_FUNCTIONS}.mpf_set_si (item, v)
		end

	set_gmp_rational (v: GMP_RATIONAL)
			-- Set from `v'.
		require
			v_attached: v /= Void
		do
			set_precision (v.precision.max ({PLATFORM}.real_64_bits.to_natural_32))
			{MPF_FUNCTIONS}.mpf_set_q (item, v.item)
		end

	set_gmp_integer (v: GMP_INTEGER)
			-- Set from `v'.
		require
			v_attached: v /= Void	
		do
			set_precision (v.precision.max ({PLATFORM}.real_64_bits.to_natural_32))
			{MPF_FUNCTIONS}.mpf_set_z (item, v.item)
		end

	set_natural_32 (v: NATURAL_32)
			-- Set from `v'.
		do
			{MPF_FUNCTIONS}.mpf_set_ui (item, v)
		end

	set_real_64 (v: REAL_64)
			-- Set from `v'.
		do
			{MPF_FUNCTIONS}.mpf_set_d (item, v)
		end

	set_string (v: STRING)
			-- Set from `v'.
		require
			v_attached: v /= Void
			v_is_decimal: is_decimal_string (v)
		local
			l_str: STRING
		do
			l_str := v.twin
			l_str.prune_all_leading ('0')
			if l_str.has ('.') then
				l_str.prune_all_trailing ('0')
			end
			if l_str ~ "." or l_str.is_empty then
				l_str := "0.0"
			end
			set_precision ((l_str.count * ({DOUBLE_MATH}.log (10) / {DOUBLE_MATH}.log (2)).ceiling).to_natural_32)
			set_string_successful := {MPF_FUNCTIONS}.mpf_set_str (item, (create {C_STRING}.make (l_str)).item, Decimal) = 0
		ensure
-- NOTE:  I have been unable to determine why `mpf_set_str' is returning -1 if `str' or `v' is some form of zero (0, 0.0, 00.0, 0.00...)
-- If you are attempting to find the source of this problem then have a look at the documentation for `mpf_set_str' in class MPF_FUNCTIONS.
-- Class MPFR has a similar problem.
			set_string_successful: (not is_zero) implies set_string_successful
		end

	set_precision (a_prec: NATURAL_32)
			-- Set `precision' to `a_prec'.
			-- If `a_prec' < `precision' then the value of `Current'
			-- will be truncated in accordance with the new `precision'.
		require
			a_prec_not_too_large: a_prec < ({NATURAL_32}.Max_value - 64)
		do
			{MPF_FUNCTIONS}.mpf_set_prec (item, a_prec)
		end

feature -- Conversion

	as_integer_32: INTEGER_32
			-- Conversion to an INTEGER_32
		do
			Result := {MPF_FUNCTIONS}.mpf_get_si (item)
		end

	as_natural_32: NATURAL_32
			-- Conversion to a NATURAL_32
		do
			Result := {MPF_FUNCTIONS}.mpf_get_ui (item)
		end

	as_gmp_integer: GMP_INTEGER
			-- Conversion to a GMP_INTEGER
		do
			create Result.make_gmp_float (Current)
		ensure
			as_gmp_integer_attached: Result /= Void
		end

	ceiling: GMP_FLOAT
			-- Smallest integral value no smaller than `Current'
		do
			create Result.make_precision (precision)
			{MPF_FUNCTIONS}.mpf_ceil (Result.item, item)
		ensure
			ceiling_attached: Result /= Void
			result_no_smaller: Result >= Current
			close_enough: Result - Current < one
		end

	floor: GMP_FLOAT
			-- Greatest integral value no greater than `Current'
		do
			create Result.make_precision (precision)
			{MPF_FUNCTIONS}.mpf_floor (Result.item, item)
		ensure
			float_attached: Result /= Void
			result_no_greater: Result <= Current
			close_enough: Current - Result < one
		end

	to_integer_32: INTEGER_32
			-- Conversion to an INTEGER_32
		require
			fits_integer_32: fits_integer_32
		do
			Result := as_integer_32
		end

	to_gmp_rational: GMP_RATIONAL
			-- Conversion to a GMP_RATIONAL
		do
			create Result.make_gmp_float (Current)
		ensure
			to_gmp_rational_attached: Result /= Void
		end

	to_gmp_integer: GMP_INTEGER
			-- Conversion to a GMP_INTEGER
		require
			is_integer: is_integer
		do
			Result := as_gmp_integer
		ensure
			to_gmp_integer_attached: Result /= Void
		end

	to_natural_32: NATURAL_32
			-- Conversion to a NATURAL_32
		require
			fits_natural_32: fits_natural_32
		do
			Result := as_natural_32
		end

	to_real_64: REAL_64
			-- Conversion to a REAL_64
		do
			Result := {MPF_FUNCTIONS}.mpf_get_d (item)
		end

feature -- Duplication

	copy (a_other: like Current)
			-- Update `Current' using fields of object attached
			-- to `a_other', so as to yield equal objects.
		do
			if item = default_pointer then
				make_precision (a_other.precision)
				{MPF_FUNCTIONS}.mpf_set (item, a_other.item)
			else
				set_precision (a_other.precision)
				{MPF_FUNCTIONS}.mpf_set (item, a_other.item)
			end
		end

feature -- Basic operations

	abs: like Current
			-- Absolute value of `Current'
		do
			create Result.make_precision (precision)
			{MPF_FUNCTIONS}.mpf_abs (Result.item, item)
		ensure
			non_negative: Result >= zero
			same_absolute_value: (Result ~ Current) or (Result ~ -Current)
			result_precision_greater_equal_precision: Result.precision >= precision
		end

	plus alias "+" (a_other: like Current): like Current
			-- Sum of `Current' and `a_other' (commutative)
		do
			create Result.make_precision (precision.max (a_other.precision))
			{MPF_FUNCTIONS}.mpf_add (Result.item, item, a_other.item)
		ensure then
			result_precision_greater_equal_precision_max_other_precision: Result.precision >= precision.max (a_other.precision)
		end

	minus alias "-" (a_other: like Current): like Current
			-- Subtraction of `a_other' from `Current'
		do
			create Result.make_precision (precision.max (a_other.precision))
			{MPF_FUNCTIONS}.mpf_sub (Result.item, item, a_other.item)
		ensure then
			result_precision_greater_equal_precision_max_other_precision: Result.precision >= precision.max (a_other.precision)
		end

	product alias "*" (a_other: like Current): like Current
			-- Product of `Current' with `a_other'
		do
			create Result.make_precision (precision.max (a_other.precision))
			{MPF_FUNCTIONS}.mpf_mul (Result.item, item, a_other.item)
		ensure then
			result_precision_greater_equal_precision_max_other_precision: Result.precision >= precision.max (a_other.precision)
		end

	quotient alias "/" (a_other: like Current): like Current
			-- Division of `Current' by `a_other'
		do
			create Result.make_precision (precision.max (a_other.precision))
			{MPF_FUNCTIONS}.mpf_div (Result.item, item, a_other.item)
		ensure then
			result_precision_greater_equal_precision_max_other_precision: Result.precision >= precision.max (a_other.precision)
		end

	identity alias "+": like Current
			-- Unary plus
		do
			create Result.make_precision (precision)
			{MPF_FUNCTIONS}.mpf_set (Result.item, item)
		ensure then
			result_precision_greater_equal_precision: Result.precision >= precision
		end

	opposite alias "-": like Current
			-- Unary minus
		do
			create Result.make_precision (precision)
			{MPF_FUNCTIONS}.mpf_neg (Result.item, item)
		ensure then
			result_precision_greater_equal_precision: Result.precision >= precision
		end

feature -- Output

	out: STRING
			-- New string containing terse printable representation
			-- of `Current'
		local
			l_exp: INTEGER_32
		do
			if is_zero then
				Result := "0"
			else
				Result := (create {C_STRING}.make_by_pointer ({MPF_FUNCTIONS}.mpf_get_str (default_pointer, $l_exp, Decimal, 0, item))).string
				if Result.item (1) = '-' then
					Result.remove_head (1)
				end
				if l_exp > 0 then
					if not is_integer then
						if l_exp > Result.count then
							Result.append_string (zeros (l_exp - Result.count))
						else
							Result.insert_character ('.', l_exp + 1)
						end
					else
						if l_exp > Result.count then
							Result.append_string (zeros (l_exp - Result.count))
						end
					end
				elseif l_exp = 0 then
					Result.prepend_string ("0.")
				elseif l_exp < 0 then
					Result.prepend_string (zeros (-l_exp))
					Result.prepend_string ("0.")
				end
				if Current < zero then
					Result.prepend_character ('-')
				end
			end
		end

feature {NONE} -- Obsolete

	exponentiable (a_other: NUMERIC): BOOLEAN
		obsolete "[2008_04_01] Will be removed since not used."
			-- May `Current' be elevated to the power `a_other'?
		do
		end

feature {NONE} -- Implementation

	Decimal: INTEGER = 10
			-- Decimal base.

	is_zero: BOOLEAN
			-- Is `Current' zero?
		do
			Result := {MPF_FUNCTIONS}.mpf_cmp_si (item, 0) = 0
		end

	zeros (v: INTEGER): STRING
			-- Create a string of zeros of length `v'.
		do
			create Result.make_filled ('0', v)
		end

end
