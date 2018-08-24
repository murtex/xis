function coeff = polyderiv_( coeff, n )
% derivative polynomial coefficients
%
% coeff = POLYDERIV_( coeff, n )
%
% INPUT
% coeff : polynomial coefficients (numeric)
% n : order of derivative (scalar numeric)
%
% OUTPUT
% coeff : polynomial coefficients (column numeric)

		% safeguard
	if nargin < 1 || ~isnumeric( coeff )
		error( 'invalid argument: coeff' );
	end

	if nargin < 2 || ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

		% compute derivative
	f = [0:size( coeff, 1 )-1]';

	for ni = 1:n
		coeff = bsxfun( @times, coeff, f );
		if size( coeff, 1 ) > 1
			coeff = [coeff(2:end, :); coeff(1, :)];
		end
	end

end % function

