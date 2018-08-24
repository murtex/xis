function s = basefun( fun )
% basename of function handle
%
% s = BASEFUN( fun )
%
% INPUT
% fun : function handle
%
% OUTPUT
% s : basename (char)

		% safeguard
	if nargin < 1 || ~isa( fun, 'function_handle' )
		error( 'invalid argument: fun' );
	end

		% extract basename
	s = func2str( fun );

	sub = strfind( s, '.' );
	if ~isempty( sub )
		s(1:sub(end)) = [];
	end

end % function

