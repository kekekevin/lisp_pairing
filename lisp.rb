def lisp_eval(x)
	if x =~ function_regex
		function = function_regex.match(x)
		if nested_function = function[2].match(function_regex)
			puts nested_function
			nested_result = chunk_through(nested_function)

			total_result = 1 + nested_result
		else
			result = chunk_through(function)
		end
	elsif x =~ /\d/
		x.to_i
	else
		true
	end	
end

def chunk_through(expr)
	operator = expr[1].to_sym
	values = expr[2].split(" ")

	if operator == :if

		if values[0] == '#t'
			eval_num_or_bool(values[1])
		else
			eval_num_or_bool(values[2])
		end
		
	else

		values.map { |v| v.to_i }.inject operator
	end

end

def eval_num_or_bool(expr)
	if expr =~ /\d/
		expr.to_i
	else
		expr == '#t'
	end
end


def function_regex
	/\((.*?)\s(.*)\)/
end