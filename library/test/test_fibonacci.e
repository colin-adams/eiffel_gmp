note

	description: "[
		Eiffel tests of GMP_FIBONACCI that can be executed by testing tool.
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class	TEST_FIBONACCI

inherit

	EQA_TEST_SET

feature -- Test routines

	test_fibonnaci
			-- Test fibonacci numbers
		note
			testing:  "covers/{GMP_FIBONACCI}.item", "covers/{FIBONACCI_ITERATOR}.item"
		local
			l_fib: GMP_FIBONACCI
			l_iter: FIBONACCI_ITERATOR
		do
			create l_fib
			assert ("zeroth_number_is_zero", l_fib.item (zero) ~ zero)
			assert ("first_number_is_one", l_fib.item (one) ~ one)
			assert ("second_number_is_one", l_fib.item (two) ~ one)
			assert ("third_number_is_two", l_fib.item (three) ~ two)
			assert ("fourth_number_is_three", l_fib.item (four) ~ three)
			assert ("fifth_number_is_five", l_fib.item (five) ~ five)
			assert ("sixth_number_is_eight", l_fib.item (six) ~ eight)
			l_iter := l_fib.at (zero, False)
			assert ("start_of_sequence_is_zero", l_iter.item ~ zero)
			l_iter.forth
			assert ("first_number_in_sequence_is_one", l_iter.item ~ one)
			l_iter.forth
			assert ("second_number_in_sequence_is_one", l_iter.item ~ one)
			l_iter.forth
			assert ("third_number_in_sequence_is_two", l_iter.item ~ two)
			l_iter.forth
			assert ("fourth_number_in_sequence_is_three", l_iter.item ~ three)
			l_iter.forth
			assert ("fifth_number_in_sequence_is_five", l_iter.item ~ five)
			l_iter.forth
			assert ("sixth_number_in_sequence_is_eight", l_iter.item ~ eight)			
		end

feature {NONE} -- Constants

	zero: GMP_INTEGER
			-- Index and expected result
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
			-- Index
		once
			create Result.make_integer_32 (4)
		end
	
	five: GMP_INTEGER
			-- Index and expected result
		once
			create Result.make_integer_32 (5)
		end

	six: GMP_INTEGER
			-- Index
		once
			create Result.make_integer_32 (6)
		end

	eight: GMP_INTEGER
			-- Expected result
		once
			create Result.make_integer_32 (8)
		end
	

end


