note
	description: "C interface to __mpz_struct struct."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPZ_STRUCT

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

feature {NONE} -- Initialization

	default_create
			-- Initialize `Current' with value 0.
		do
			make
			{MPZ_FUNCTIONS}.mpz_init (item)
		end

feature -- Measurement

	structure_size: INTEGER_32
			-- Size to allocate (in bytes)
		do
			Result := c_structure_size.to_integer_32
		end

feature -- Removal

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
		do
			{MPZ_FUNCTIONS}.mpz_clear (item)
		end

feature {NONE} -- Externals

	c_structure_size: NATURAL_64
			-- Size to allocate (in bytes)
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (size_t)sizeof(__mpz_struct);
			]"
		end

end
