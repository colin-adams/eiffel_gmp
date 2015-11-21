note
	description: "C interface to __mpf_struct struct."
	author: "Chris Saunders"
	date: "$Date: 2010-06-03 (Thurs, 03 June 2010) $"
	revision: "$Revision: 1.0.0.0 $"

class
	MPF_STRUCT

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
			-- Initialize `Current' with value 0.0 and default precision.
		do
			make
			{MPF_FUNCTIONS}.mpf_init (item)
		end

	make_precision (prec: NATURAL_32)
			-- Initialize `Current' with value 0.0 and precision `prec'.
		do
			make
			{MPF_FUNCTIONS}.mpf_init2 (item, prec)
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
			{MPF_FUNCTIONS}.mpf_clear (item)
		end

feature {NONE} -- Externals

	c_structure_size: NATURAL_64
			-- Size to allocate (in bytes)
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (size_t)sizeof(__mpf_struct);
			]"
		end

end
