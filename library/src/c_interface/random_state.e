note
	description: "C interface to __gmp_randstate_struct struct."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	RANDOM_STATE

inherit
	MEMORY
		redefine
			default_create,
			dispose
		end

	MEMORY_STRUCTURE
		redefine
			default_create
		end

create
	default_create,
	make_lc_2exp,
	make_lc_2exp_size

feature {NONE} -- Initialization

	default_create
			-- Initialize `Current'.
		do
			make
			{RANDOM_STATE_INITIALIZATION}.gmp_randinit_default (item)
		end

	make_lc_2exp (a: GMP_INTEGER; c, m2exp: NATURAL_32)
			-- Initialize with a linear congruential algorithm X = (`a'*X + `c') mod 2^`m2exp'.
			-- The low bits of X in this algorithm are not very random.
			-- The least significant bit will have a period no more than 2, and the second bit no more
			-- than 4, etc.
			-- For this reason only the high half of each X is actually used.
			-- When a random number of more than `m2exp'/2 bits is to be generated, multiple iterations
			-- of the recurrence are used and the results concatenated.
		do
			make
			{RANDOM_STATE_INITIALIZATION}.gmp_randinit_lc_2exp (item, a.item, c, m2exp)
		end

	make_lc_2exp_size (size: NATURAL_32)
			-- Initialize for a linear congruential algorithm as per `gmp_randinit_lc_2exp'.
			-- a, c and m2exp are selected from a table, chosen so that `size' bits (or more) of each X will be used, ie. m2exp/2 >= `size'.
			-- If successful the return value is non-zero.
			-- If `size' is bigger than the table data provides then the return value is zero.
		require
			size_not_negative: not (size < 0)
			size_small_enough: size <= Maximum_size
		do
			make
			make_lc_2exp_size_succeeded := {RANDOM_STATE_INITIALIZATION}.gmp_randinit_lc_2exp_size (item, size) /= 0
		end

feature -- Measurement

	structure_size: INTEGER_32
			-- Size to allocate (in bytes)
		do
			Result := c_structure_size.to_integer_32
		end

feature -- Status report

	make_lc_2exp_size_succeeded: BOOLEAN
			-- Did the last call to `make_lc_2exp_size' succeed?

	Maximum_size: NATURAL_32 = 128
			-- Maximum value for the `size' argument to `make_lc_2exp_size'.

feature -- Element change

	set_seed (v: GMP_INTEGER)
			-- Set the seed value from `v'.
		do
			{RANDOM_STATE_SEEDING}.gmp_randseed (item, v.item)
		end

	set_seed_natural_32 (v: NATURAL_32)
			-- Set the seed value from `v'.
		do
			{RANDOM_STATE_SEEDING}.gmp_randseed_ui (item, v)
		end

feature -- Removal

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			{RANDOM_STATE_INITIALIZATION}.gmp_randclear (item)
		end

feature {NONE} -- Externals

	c_structure_size: NATURAL_64
			-- Size to allocate (in bytes)
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (size_t)sizeof(__gmp_randstate_struct);
			]"
		end

end
