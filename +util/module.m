function m = module( n )
% get module name
%
% m = MODULE( n )
%
% INPUT
% n : stack index (scalar numeric)
%
% OUTPUT
% m : module name (char)

		% safeguard
	if nargin < 1
		n = 0;
	end
	if ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

		% get module information
	n = abs( n );
	[st, i] = dbstack();

	if numel( st ) > i+n
		m = st(i+n+1).name;
	else
		m = '';
	end

end

