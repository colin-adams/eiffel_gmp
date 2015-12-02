note

	description: "[
		Countably infinite sequences where values are associated with
		GMP_INTEGERs from a continuous interval.
	]"

	author: "Colin Adams"
	date: "$Date$"
	revision: "$Revision$"

deferred class	INFINITE_SEQUENCE [G]

inherit

	ITERABLE [G]

feature -- Access

	lower_bound: detachable GMP_INTEGER
			-- Starting index for ascending semi-infinite sequences;
			-- E.g. the natural numbers start at 0 or 1
		deferred
		end
	
	upper_bound: detachable GMP_INTEGER
			-- Starting index for descending semi-infinite sequences;
			-- E.g. the strictly negative integers start at -1
		deferred
		end

	item alias "[]" (a_index: GMP_INTEGER): G
			-- Value associated with `a_index'
		require
			a_index_attached: a_index /= Void
			a_index_valid: valid_index (a_index)
		deferred
		end

feature -- Measurement

	is_semi_infinite: BOOLEAN
			-- Do we have a bound (lower or upper) on the sequence?
		do
			Result := attached lower_bound or attached upper_bound
		ensure
			definition: Result = (attached lower_bound xor attached upper_bound)
		end

feature -- Status report

	default_descending: BOOLEAN
			-- Does the index decrease by default when iterating?
		deferred
		end

	valid_direction (a_descending: BOOLEAN): BOOLEAN
			-- Is `a_descending' a valid iteration direction for `Current'?
			-- N.B. This is for use of the features in the Iteration feature clause.
			-- Descendants may choose to implemt other iteration features that
			-- don't require respecting this function.
			-- E.g. a NATURAL_NUMBERS class might choose to support finite descent.
		deferred
		end
			
	valid_index (a_index: GMP_INTEGER): BOOLEAN
			-- Is `a_index' valid for direct access?
			-- I.e. may we call `item [a_index]'?
		require
			a_index_attached: a_index /= Void
		do
			if attached lower_bound as l_lower then
				Result := a_index >= l_lower
			elseif attached upper_bound as l_upper then
				Result := a_index <= l_upper
			else
				Result := True
			end
		end

	valid_iteration_start (a_start_position: GMP_INTEGER): BOOLEAN
			-- Is `a_start_position' valid for use as the starting position when calling `at' etc. ?
		require
			a_start_position_attached: a_start_position /= Void
		do
			Result := valid_index (a_start_position)
		ensure
			valid_iteration_start_implies_valid_index: Result implies valid_index (a_start_position)
		end
	
feature -- Iteration

	new_cursor: like at
			-- New iterator pointing to the bound, or to zero, if unbounded;
			-- Direction is implicit from the bound, or `default_descending' if unbounded.
		do
			if attached lower_bound as l_lower then
				Result := ascending_from (l_lower)
			elseif attached upper_bound as l_upper then
				Result := descending_from (l_upper)
			else
				Result := at (zero, default_descending)
			end
		end

	at (a_start_position: GMP_INTEGER; a_descending: BOOLEAN): INFINITE_SEQUENCE_ITERATOR [G]
			-- New iterator pointing to `a_start_position'
		require
			a_start_position_attached: a_start_position /= Void
			a_start_position_valid: valid_iteration_start (a_start_position)
			a_descending_supported: valid_direction (a_descending)
		deferred
		ensure then
			correct_starting_point: Result.starting_position ~ a_start_position
			correct_direction: a_descending = Result.descending
		end

	ascending_from (a_start_position: GMP_INTEGER): like at
			-- New ascending iterator pointing to `a_start_position'
		require
			a_start_position_attached: a_start_position /= Void
			a_start_position_valid: valid_iteration_start (a_start_position)
			a_descending_supported: valid_direction (False)
			no_upper_bound: not attached upper_bound
		deferred
		ensure then
			correct_starting_point: Result.starting_position ~ a_start_position
			ascending: not Result.descending
		end

	descending_from (a_start_position: GMP_INTEGER): like at
			-- New descending iterator pointing to `a_start_position'
		require
			a_start_position_attached: a_start_position /= Void
			a_start_position_valid: valid_iteration_start (a_start_position)
			a_descending_supported: valid_direction (True)
			no_lower_bound: not attached lower_bound
		deferred
		ensure then
			correct_starting_point: Result.starting_position ~ a_start_position
			descending: Result.descending
		end

feature {NONE} -- Implementation

	zero: GMP_INTEGER
			-- Default starting point for unbound iterations
		once
			create Result
		end

invariant

	infinite: not (attached lower_bound and attached upper_bound)
	default_descending_valid: valid_direction (default_descending)
	upper_bound_implies_descending_valid: attached upper_bound implies valid_direction (True)
	lower_bound_implies_ascending_valid: attached lower_bound implies valid_direction (False)
	upper_bound_implies_ascending_invalid: attached upper_bound implies not valid_direction (False)
	lower_bound_implies_descending_invalid: attached lower_bound implies not valid_direction (True)

end
