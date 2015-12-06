note

	description: "[
		Eiffel tests of GMP_FACTORIAL that can be executed by testing tool.
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class	TEST_FACTORIAL

inherit

	EQA_TEST_SET

feature -- Test routines

	test_factorial
			-- New test routine
		note
		testing:  "covers/{GMP_FACTORIAL}.item", "covers/{FACTORIAL_ITERATOR}.item"
		local
			l_fac: GMP_FACTORIAL
			l_iter: FACTORIAL_ITERATOR
		do
			create l_fac
			assert ("zeroth_number_is_one", l_fac.item (zero) ~ one)
			assert ("first_number_is_one", l_fac.item (one) ~ one)
			assert ("second_number_is_two", l_fac.item (two) ~ two)
			assert ("third_number_is_six", l_fac.item (three) ~ six)
			assert ("fourth_number_is_twentyfour", l_fac.item (four) ~ twentyfour)
			assert ("fifth_number_is_onetwenty", l_fac.item (five) ~ onetwenty)
			assert ("sixth_number_is_seventwenty", l_fac.item (six) ~ seventwenty)
			l_iter := l_fac.at (zero, False)
			assert ("start_of_sequence_is_one", l_iter.item ~ one)
			l_iter.forth
			assert ("first_number_in_sequence_is_one", l_iter.item ~ one)
			l_iter.forth
			assert ("second_number_in_sequence_is_two", l_iter.item ~ two)
			l_iter.forth
			assert ("third_number_in_sequence_is_six", l_iter.item ~ six)
			l_iter.forth
			assert ("fourth_number_in_sequence_is_twentyfour", l_iter.item ~ twentyfour)
			l_iter.forth
			assert ("fifth_number_in_sequence_is_onetwenty", l_iter.item ~ onetwenty)
			l_iter.forth
			assert ("sixth_number_in_sequence_is_seventwenty", l_iter.item ~ seventwenty)		
		end

feature {NONE} -- Constants

	zero: GMP_INTEGER
			-- Index
		once
			create Result
		end

	one: GMP_INTEGER
			-- Index and expected result
		once
			create Result.make_integer_32 (1)
		end

	two: GMP_INTEGER
			-- Index and expected result
		once
			create Result.make_integer_32 (2)
		end
	
	three: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (3)
		end

	four: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (4)
		end
	
	five: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (5)
		end

	six: GMP_INTEGER
			-- Index and expected result
		once
			create Result.make_integer_32 (6)
		end

	twentyfour: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (24)
		end
	
	seventwenty: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (720)
		end
	
	onetwenty: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (120)
		end
	

end


