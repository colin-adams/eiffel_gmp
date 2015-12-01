note
	description: "Summary description for {AUTOTEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTOTEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			-- nothing to do
		end

feature -- Classes under test

	gmp_integer: detachable GMP_INTEGER

	gmp_rational: detachable GMP_RATIONAL

	gmp_float: detachable GMP_FLOAT

end
