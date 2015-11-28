note

	description: "Demonstration of class GMP_FIBONACCI"

	author: "Colin Adams"
	date: "$Date: $"
	revision: "$Revision:  $"
	
class FIBONACCI_DEMO

create

	make

feature {NONE} -- Initialization

	make
			-- Run application
		local
			i: GMP_INTEGER
			l_fib: GMP_FIBONACCI
		do
			create l_fib
			print ("F(0) = " + l_fib.item (zero).out + " (expected 0)%N")
			print ("F(1) = " + l_fib.item (one).out + " (expected 1)%N")
			print ("F(11) = " + l_fib.item (eleven).out + " (expected 89)%N")
			-- VERY VERY long time print ("F(" + {NATURAL_64}.max_value.out + ") = " + l_fib.item (large_index).out + 
			-- "%N")
			create i
			across l_fib as i_fib loop
				print ("F(" + i.out + ") = " + i_fib.item.out + "%N")
				i := i + one
			end
		end

feature {NONE} -- Implementation

	zero: GMP_INTEGER
			-- Index number
		once
			create Result
		end

	one: GMP_INTEGER
			-- Index number
		once
			create Result.make_integer_32 (1)
		end

	eleven: GMP_INTEGER
			-- Index number
		once
			create Result.make_integer_32 (11)
		end

	large_index: GMP_INTEGER
			-- Index number
		once
			create Result.make_string ({NATURAL_64}.max_value.out)
		end
	
end
