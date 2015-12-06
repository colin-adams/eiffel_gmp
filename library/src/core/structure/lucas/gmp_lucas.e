note

	description: "The Lucas number sequence"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

class GMP_LUCAS

inherit

	INFINITE_SEQUENCE [GMP_INTEGER]
		redefine
			valid_iteration_start, lower_bound
		end

feature -- Access

	lower_bound: GMP_INTEGER
			-- Starting index for ascending semi-infinite sequences
		once
			Result := zero
		end

	upper_bound: detachable GMP_INTEGER
		-- Starting index for descending semi-infinite sequences
		do
		ensure then
			no_upper_bound: not attached Result
		end
	
	item alias "[]" (a_index: GMP_INTEGER): GMP_INTEGER
			-- Value associated with `a_index';
			-- Efficient only when `a_index.fits_natural_32' holds.
			-- Otherwise we have to enumerate all the numbers from 
			-- {NATURAL_32}.Max_value
		local
			l_start_index: GMP_INTEGER
			l_cursor: like at
		do
			if a_index.fits_natural_32 then
				create Result
				{MPZ_FUNCTIONS}.mpz_lucnum_ui (Result.item, a_index.to_natural_32)
			else
				create l_start_index.make_natural_32 (({NATURAL_32} 0).Max_value)
				l_cursor := at (l_start_index, False)
				from
				until
					l_cursor.index ~ a_index
				loop
					l_cursor.forth
				end
				Result := l_cursor.item
			end
		end

feature -- Status report

	default_descending: BOOLEAN
			-- Does the index decrease by default when iterating?
			-- (Answer - No)
	
	valid_direction (a_descending: BOOLEAN): BOOLEAN
			-- Is `a_descending' a valid iteration direction for `Current'?
		do
			Result := not a_descending
		ensure then
			 only_ascending: Result = (not a_descending)
		end

	valid_iteration_start (a_start_position: GMP_INTEGER): BOOLEAN
			-- Is `a_start_position' valid for use as the starting position when calling `at' etc. ?
		do
			Result := valid_index (a_start_position) and then a_start_position.fits_natural_32
		end

feature -- Iteration

	at (a_start_position: GMP_INTEGER; a_descending: BOOLEAN): LUCAS_ITERATOR
			-- New iterator pointing to `a_start_position'
		do
			create Result.make (Current, a_start_position)
		end
	
	ascending_from (a_start_position: GMP_INTEGER): like at
			-- New ascending iterator pointing to `a_start_position'
		do
			create Result.make (Current, a_start_position)
		end

	descending_from (a_start_position: GMP_INTEGER): like at
			-- New descending iterator pointing to `a_start_position'
		do
			-- precondition is never met.
			-- to satisfy void-safety compiler:
			Result := ascending_from (a_start_position)
		end
	
invariant

	ascending_iteration_only: not default_descending

end
