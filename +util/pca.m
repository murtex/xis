function [xp, v, lambda] = pca( x )
% principal components analysis
%
% [xp, v, lambda] = PCA( x )
%
% INPUT
% x : data (matrix numeric [dim, samples])
%
% OUTPUT
% xp : transformed data (matrix numeric [dim, samples])
% v : cov eigenvectors (TODO)
% lambda : cov eigenvalues (column numeric)

		% safeguard
	if nargin < 1 || ~ismatrix( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% principal components analysis
	x = bsxfun( @minus, x, mean( x, 2 ) ); % covariances
	cov = x*x' / (size( x, 2 )-1);
	[v, lambda] = eig( cov, 'nobalance' );

	xp = (x'*v)'; % transformation
	lambda = diag( lambda );

end

