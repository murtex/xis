function y = polyval_( coeff, x )
% polynomial evaluation
%
% y = POLYVAL_( coeff, x )
%
% INPUT
% coeff : polynomial coefficients (numeric)
% x : location of evaluation (numeric)
%
% OUTPUT
% y : value (numeric)

		% safeguard
	if nargin < 1 || ~isnumeric( coeff )
		error( 'invalid argument: coeff' );
	end

	if nargin < 2 || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% evaluate polynomial
	y = sum( coeff.*bsxfun( @power, x, [0:size( coeff, 1 )-1]' ), 1 );

end % function

