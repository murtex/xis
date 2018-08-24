function chain = chainstr( delims, varargin )
% chain strings
%
% chain = CHAINSTR( delims, ... )
%
% INPUT
% delims: string delimiters (char, cell string)
% ... : strings (char)
%
% OUTPUT
% chain : chained strings (char)

		% safeguard
	if nargin < 1
		error( 'invalid argument: delims' );
	end
	if ischar( delims )
		delims = {delims, delims};
	end
	if ~iscellstr( delims ) || numel( delims ) ~= 2
		error( 'invalid argument: delims' );
	end

		% chain strings
	chain = '';

	ci = 0;
	for vi = 1:numel( varargin )
		if isempty( varargin{vi} )
			continue;
		end

		ci = ci+1;
		if ci > 1
			if ci < numel( varargin )
				chain = sprintf( '%s%s', chain, delims{1} );
			else
				chain = sprintf( '%s%s', chain, delims{2} );
			end
		end
		chain = sprintf( '%s%s', chain, varargin{vi} );
	end

end % function

