note

	description: "Rational numbers"

	author: "Chris Saunders; Colin Adams"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class GMP_RATIONAL

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

	MPQ_STRUCT
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
	make_integer_32_2,
	make_gmp_float,
	make_gmp_integer,
	make_natural_32,
	make_natural_32_2,
	make_real_64,
	make_string


feature {NONE} 

	make_integer_32 (v: INTEGER_32)
			-- Initialize as `v'/1.
		do
			default_create
			set_integer (v)
		end

	make_integer_32_2 (v1: INTEGER_32; v2: NATURAL_32)
			-- Initialize as `v1'/'v2' reduced to canonical form.
		do
			default_create
			set_integer_2 (v1, v2)
		end

	make_gmp_float (v: GMP_FLOAT)
			-- Initialize as exact value of `v'.	
		do
			default_create
			set_gmp_float (v)
		end

	make_gmp_integer (v: GMP_INTEGER)
			-- Initialize as `v'/1.
		do
			default_create
			set_gmp_integer (v)
		end

	make_natural_32 (v: NATURAL_32)
			-- Initialize as `v'/1.
		do
			default_create
			set_natural (v)
		end

	make_natural_32_2 (v1, v2: NATURAL_32)
			-- Initialize as `v1'/`v2'.
		do
			default_create
			set_natural_2 (v1, v2)
		end

	make_real_64 (v: REAL_64)
			-- Initialize as exact value of `v'.
		do
			default_create
			set_real_64 (v)
		end

	make_string (v: STRING_8)
			-- Initialize from `v' interpreted as a rational number.
		require
			is_decimal_rational_string: is_decimal_rational_string (v)
		do
			default_create
			set_string (v)
		end
	
feature -- Access

	numerator: GMP_INTEGER assign set_numerator
			-- Numerator of `Current' in canonical form
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_get_num (Result.item, item)
		end

	denominator: GMP_INTEGER assign set_denominator
			-- Denominator of `Current' in canonical form
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_get_den (Result.item, item)
		end

	sign: INTEGER_32
			-- 0 if = 0, 1 if > 0, -1 if < 0
		do
			Result := {MPQ_FUNCTIONS}.mpq_sgn (item)
		ensure
			three_way: Result = three_way_comparison (zero)
		end

	one: like Current
			-- Unit for muliplication
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_set_si (Result.item, 1, 1)
		end

	zero: like Current
			-- Unit for addition
		do
			create Result
		end
	
feature -- Status report

	precision: NATURAL_32
		do
			Result := numerator.precision.max (denominator.precision)
		end

	divisible (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := {MPQ_FUNCTIONS}.mpq_cmp_si (other.item, 0, 1) /= 0
		end

	is_decimal_rational_string (v: STRING_8): BOOLEAN
			-- Is `v' in a suitable format for `set_string' or `make_string'?
		local
			c: CHARACTER_8
			i, l_divide_symbol_index: INTEGER_32
			l_str_num, l_str_den: STRING_8
		do
			l_divide_symbol_index := v.index_of ('/', 1)
			if l_divide_symbol_index = 0 then
				l_str_num := v
				c := l_str_num.item (1)
				if c = '-' or else c = '+' then
					l_str_num := l_str_num.substring (2, l_str_num.count)
				end
				l_str_num.prune_all (' ')
				from
					i := 1
					Result := True
				until
					(not Result) or else (i > l_str_num.count)
				loop
					Result := l_str_num.item (i).is_digit
					i := i + 1
				end
			else
				l_str_num := v.substring (1, l_divide_symbol_index - 1)
				c := l_str_num.item (1)
				if c = '-' or else c = '+' then
					l_str_num := l_str_num.substring (2, l_divide_symbol_index - 1)
				end
				l_str_num.prune_all (' ')
				from
					i := 1
					Result := True
				until
					(not Result) or else (i > l_str_num.count)
				loop
					Result := l_str_num.item (i).is_digit
					i := i + 1
				end
				l_str_den := v.substring (l_divide_symbol_index + 1, v.count)
				c := l_str_den.item (1)
				if c = '-' or else c = '+' then
					l_str_den := l_str_den.substring (2, l_str_den.count)
				end
				l_str_den.prune_all (' ')
				from
					i := 1
				until
					(not Result) or else (i > l_str_den.count)
				loop
					Result := l_str_den.item (i).is_digit
					i := i + 1
				end
			end
		end

	is_integer: BOOLEAN
			-- Does `Current''s canonical form match pattern v/1?
		do
			Result := denominator ~ denominator.one
		end

	set_string_successful: BOOLEAN
			-- Did last call to `set_string'/`make_string' succeed?
			-- Must be true if precondition were met and no exception 
			-- were raised.
	
feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := {MPQ_FUNCTIONS}.mpq_equal (item, other.item) /= 0
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := {MPQ_FUNCTIONS}.mpq_cmp (item, other.item) < 0
		end
	
feature -- Setting

	set_numerator (v: GMP_INTEGER)
			-- Set `numerator' to `v' then canonicalize.
		do
			{MPQ_FUNCTIONS}.mpq_set_num (item, v.item)
			{MPQ_FUNCTIONS}.mpq_canonicalize (item)
		end

	set_denominator (v: GMP_INTEGER)
			-- Set `denominator' to `v' then canonicalize.
		do
			{MPQ_FUNCTIONS}.mpq_set_den (item, v.item)
			{MPQ_FUNCTIONS}.mpq_canonicalize (item)
		end

	set_integer (v: INTEGER_32)
			-- Set `Current' to `v'/1.
		do
			{MPQ_FUNCTIONS}.mpq_set_si (item, v, 1)
			{MPQ_FUNCTIONS}.mpq_canonicalize (item) -- hm. this should be unnecessary - comment out when test suite available.
		ensure
			denominator_one: denominator ~ One
		end

	set_integer_2 (v1: INTEGER_32; v2: NATURAL_32)
			-- Set `Current' to value of `v1'/`v2' reduced to canonical form.
		do
			{MPQ_FUNCTIONS}.mpq_set_si (item, v1, v2)
			{MPQ_FUNCTIONS}.mpq_canonicalize (item)
		end

	set_gmp_float (v: GMP_FLOAT)
			-- Set `Current' to exact value of `v'.
		do
			{MPQ_FUNCTIONS}.mpq_set_f (item, v.item)
		end

	set_gmp_integer (v: GMP_INTEGER)
			-- Set `Current' to `v'/1.
		do
			{MPQ_FUNCTIONS}.mpq_set_z (item, v.item)
		ensure
			numerator_set: numerator ~ v
			denominator_one: denominator ~ denominator.one
		end

	set_natural (v: NATURAL_32)
			-- Set `Current' to `v'/1.
		do
			{MPQ_FUNCTIONS}.mpq_set_ui (item, v, 1)
		end

	set_natural_2 (v1, v2: NATURAL_32)
			-- Set `Current' to value of `v1'/`v2' reduced to canonical 
			-- form.
		do
			{MPQ_FUNCTIONS}.mpq_set_ui (item, v1, v2)
			{MPQ_FUNCTIONS}.mpq_canonicalize (item)
		end

	set_real_64 (v: REAL_64)
			-- Set `Current' to exact value of `v'.
		do
			{MPQ_FUNCTIONS}.mpq_set_d (item, v)
		end

	set_string (v: STRING_8)
			-- Set `Current' to `v' interpreted as a rational number.
		require
			is_decimal_rational_string: is_decimal_rational_string (v)
		do
			set_string_successful := {MPQ_FUNCTIONS}.mpq_set_str (item, (create {C_STRING}.make (v)).item, Decimal) = 0
			{MPQ_FUNCTIONS}.mpq_canonicalize (item)
		ensure
			set_string_successful: set_string_successful
		end
	
feature 

	as_gmp_integer: GMP_INTEGER
			-- Truncation of `Current' to an integer
		do
			create Result.make_gmp_rational (Current)
		end

	to_binary_string: STRING_8
			-- Representation of `Current' as the ratio of two binary substrings
		do
			Result := numerator.to_binary_string + " / " + denominator.to_binary_string
		end

	to_hex_string: STRING_8
			-- Representation of `Current' as the ratio of two hexadecimal substrings
		do
			Result := numerator.to_hex_string + " / " + denominator.to_hex_string
		end

	to_gmp_float: GMP_FLOAT
			-- `Current' as a floating point number
		do
			create Result.make_gmp_rational (Current)
		end

	to_gmp_integer: GMP_INTEGER
			-- `Current' as an integer
		require
			is_integer: is_integer
		do
			Result := as_gmp_integer
		end

	to_real_64: REAL_64
			-- `Current' as a floating point number;
			-- May be truncated
		do
			Result := {MPQ_FUNCTIONS}.mpq_get_d (item)
		end
	
feature -- Duplication

	copy (a_other: like Current)
			-- <Precursor>
		do
			if item = default_pointer then
				default_create
			end
			{MPQ_FUNCTIONS}.mpq_set (item, a_other.item)
		end
	
feature -- Basic operations

	abs: like Current
			-- Absolute value of `Current'
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_abs (Result.item, item)
		ensure
			non_negative: Result >= Zero
			same_absolute_value: (Result ~ Current) or (Result ~ - Current)
		end

	plus alias "+" (other: like Current): like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_add (Result.item, item, other.item)
		end

	minus alias "-" (other: like Current): like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_sub (Result.item, item, other.item)
		end

	product alias "*" (other: like Current): like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_mul (Result.item, item, other.item)
		end

	quotient alias "/" (other: like Current): like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_div (Result.item, item, other.item)
		end

	identity alias "+": like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_set (Result.item, item)
		end

	opposite alias "-": like Current
			-- <Precursor>
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_neg (Result.item, item)
		end

	inverse: like Current
			-- 1 / `Current'
		require
			not_zero: not (Current ~ Zero)
		do
			create Result
			{MPQ_FUNCTIONS}.mpq_inv (Result.item, item)
		end
	
feature -- Output

	out: STRING_8
			-- <Precursor>
		do
			if denominator ~ denominator.one then
				Result := numerator.out
			else
				Result := numerator.out + " / " + denominator.out
			end
		end
	
feature -- Status report

	exponentiable (other: NUMERIC): BOOLEAN
		obsolete "[2008_04_01] Will be removed since not used."
		do
		end
	
feature {NONE} -- Number bases for string setting

	Binary: INTEGER_32 = 2
			-- Base 2
	
	Decimal: INTEGER_32 = 10
			-- Base 10
	
	Hexadecimal: INTEGER_32 = 16
			-- Base 16
	
invariant
	
	denominator_not_zero: denominator /~ denominator.zero

end

