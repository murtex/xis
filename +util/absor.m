function q = absor( rref, r )
% horn's absolute orientation
%
% q = ABSOR( rref, r )
%
% INPUT
% rref : reference set of vectors (matrix numeric [count, 3])
% r : set of vectors (matrix numeric [count, 3])
%
% OUTPUT
% q : normalized corrective quaternion (row numeric [w, x, y, z])
%
% REFERENCES
% [1] Horn, Closed-form solution of absolute orientation using unit quaternions, JOSA, 1987

		% safeguard
	if nargin < 1 || ~ismatrix( rref ) || size( rref, 2 ) ~= 3 || ~isnumeric( rref )
		error( 'invalid argument: rref' );
	end

	if nargin < 2 || ~ismatrix( r ) || size( r, 1 ) ~= size( rref, 1 ) || size( r, 2 ) ~= 3 || ~isnumeric( r )
		error( 'invalid argument: r' );
	end

		% horn's method [1]
	q = [1, 0, 0, 0];

	xpref = rref(:, 1); % cartesian components
	ypref = rref(:, 2);
	zpref = rref(:, 3);
	xp = r(:, 1);
	yp = r(:, 2);
	zp = r(:, 3);

	Sxx = sum( xp.*xpref ); % mutual products
	Sxy = sum( xp.*ypref );
	Sxz = sum( xp.*zpref );
	Syx = sum( yp.*xpref );
	Syy = sum( yp.*ypref );
	Syz = sum( yp.*zpref );
	Szx = sum( zp.*xpref );
	Szy = sum( zp.*ypref );
	Szz = sum( zp.*zpref );

	N = [Sxx+Syy+Szz, Syz-Szy, Szx-Sxz, Sxy-Syx; ... % symmetric matrix
		Syz-Szy, Sxx-Syy-Szz, Sxy+Syx, Szx+Sxz; ...
		Szx-Sxz, Sxy+Syx, -Sxx+Syy-Szz, Syz+Szy; ...
		Sxy-Syx, Szx+Sxz, Syz+Szy, -Sxx-Syy+Szz];

	[evec, eval] = eig( N, 'nobalance' ); % eigenvectors and values
	eval = diag( eval );
	[~, perm] = sort( eval );

	q = evec(:, perm(end)); % quaternion

end % function

