function str = any2str( var )
% string conversion
%
% str = ANY2STR( var )
%
% INPUT
% var : variable
%
% OUTPUT
% str : string representation (row char)

		% safeguard
	if nargin < 1
		str = '';
		return;
	end

		% conversion
	str = '';

	switch class( var )
		case 'cell'
			str = sprintf( '{%s', str );
			for i = 1:numel( var )
				if i > 1
					str = sprintf( '%s, ', str );
				end
				str = sprintf( '%s%s', str, util.any2str( var{i} ) );
			end
			str = sprintf( '%s}', str );

		case 'double'
			if numel( var ) ~= 1
				str = sprintf( '[%s', str );
			end
			for i = 1:numel( var )
				if i > 1
					str = sprintf( '%s, ', str );
				end
				str = sprintf( '%s%g', str, var(i) );
			end
			if numel( var ) ~= 1
				str = sprintf( '%s]', str );
			end

		case 'char'
			str = sprintf( '''%s''', var );

		case 'logical'
			if numel( var ) ~= 1
				str = sprintf( '[%s', str );
			end
			for i = 1:numel( var )
				if i > 1
					str = sprintf( '%s, ', str );
				end
				if var(i)
					str = sprintf( '%s%s', str, 'true' );
				else
					str = sprintf( '%s%s', str, 'false' );
				end
			end
			if numel( var ) ~= 1
				str = sprintf( '%s]', str );
			end

		case 'struct'
			if numel( var ) == 1
				fn = fieldnames( var );
				str = sprintf( '(%s', str );
				for i = 1:numel( fn )
					if i > 1
						str = sprintf( '%s, ', str );
					end
					str = sprintf( '%s%s=%s', str, fn{i}, util.any2str( var.(fn{i}) ) );
				end
				str = sprintf( '%s)', str );
			else
				str = 'struct array (TODO)';
			end

		otherwise
			if isobject( var )
				str = 'object (TODO)';
			else
				error( 'invalid value: var' );
	end

end % function
