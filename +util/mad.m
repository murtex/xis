function m = mad( x )
% median absolute deviation
% 
% m = MAD( x )
%
% INPUT
% x : data (vector numeric)
%
% OUTPUT
% m : median absolute deviation (scalar numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% compute mad
	x = x(~isnan( x ));
	m = median( abs( x-median( x ) ) );

end % function

