function md = mahal( x, pop )
% mahalanobis distance
%
% md = MAHAL( x, pop )
%
% INPUT
% x : data (matrix numeric [dim, samples])
% pop : population data (matrix numeric [dim, samples])
%
% OUTPUT
% md : mahalanobis distance (row vector)

		% safeguard
	if nargin < 1 || ~ismatrix( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 2 || ~ismatrix( pop ) || size( pop, 1 ) ~= size( x, 1 ) || ~isnumeric( pop )
		error( 'invalid argument: pop' );
	end

		% compute mahalanobis distance
	md = NaN( [1, size( x, 2 )] );

	mu = mean( pop, 2 );
	pop = bsxfun( @minus, pop, mu );
	sigma = pop*pop' / (size( pop, 2 )-1);
	
	x = bsxfun( @minus, x, mu );
	for i = 1:size( x, 2 )
		md(i) = x(:, i)'*inv( sigma )*x(:, i);
	end

	md = sqrt( md );

end % function

