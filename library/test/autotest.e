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
		end

feature -- Classes under test

	gmp_integer: detachable GMP_INTEGER

	gmp_rational: detachable GMP_RATIONAL

	gmp_float: detachable GMP_FLOAT

	fibs: FIBONACCI_ITERATOR

	lucas: LUCAS_ITERATOR

	integer_maths: GMP_INTEGER_MATH

	rational_maths: GMP_RATIONAL_MATH

	floating_math: GMP_FLOAT_MATH

end
