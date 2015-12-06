note

	description: "[
		Eiffel tests of GMP_LUCAS that can be executed by testing tool.
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class	TEST_LUCAS

inherit

	EQA_TEST_SET

feature -- Test routines

	test_lucas
			-- Test Lucas numbers
		note
			testing:  "covers/{GMP_LUCAS}.item", "covers/{LUCAS_ITERATOR}.item"
		local
			l_lucas: GMP_LUCAS
			l_iter: LUCAS_ITERATOR
		do
			create l_lucas
			assert ("zeroth_number_is_two", l_lucas.item (zero) ~ two)
			assert ("first_number_is_one", l_lucas.item (one) ~ one)
			assert ("second_number_is_three", l_lucas.item (two) ~ three)
			assert ("third_number_is_four", l_lucas.item (three) ~ four)
			assert ("fourth_number_is_seven", l_lucas.item (four) ~ seven)
			assert ("fifth_number_is_eleven", l_lucas.item (five) ~ eleven)
			assert ("sixth_number_is_eightteen", l_lucas.item (six) ~ eighteen)
			l_iter := l_lucas.at (zero, False)
			assert ("start_of_sequence_is_two", l_iter.item ~ two)
			l_iter.forth
			assert ("first_number_in_sequence_is_one", l_iter.item ~ one)
			l_iter.forth
			assert ("second_number_in_sequence_is_three", l_iter.item ~ three)
			l_iter.forth
			assert ("third_number_in_sequence_is_four", l_iter.item ~ four)
			l_iter.forth
			assert ("fourth_number_in_sequence_is_seven", l_iter.item ~ seven)
			l_iter.forth
			assert ("fifth_number_in_sequence_is_eleven", l_iter.item ~ eleven)
			l_iter.forth
			assert ("sixth_number_in_sequence_is_eight", l_iter.item ~ eighteen)			
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
			-- Index and expected result
		once
			create Result.make_integer_32 (3)
		end

	four: GMP_INTEGER
			-- Index and expected result
		once
			create Result.make_integer_32 (4)
		end
	
	five: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (5)
		end

	six: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (6)
		end

	seven: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (7)
		end
	

	eleven: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (11)
		end
	

	eighteen: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (18)
		end
	

end


