note
	description: "Summary description for {GMP_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GMP_CONSTANTS

feature -- Access

	Mp_bits_per_limb: INTEGER_32
			--
		external
			"C inline use %"gmp.h%""
		alias
			"[
				return (int)mp_bits_per_limb;
			]"
		end

end
