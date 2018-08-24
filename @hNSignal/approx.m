function approx( this, n, m, k )
% initialte spline approximation
%
% APPROX( this, n, m, k )
%
% INPUT
% this : signal (scalar object)
% n : order of polynomial (scalar numeric)
% m : number of knot conditions (scalar numeric)
% k : number of continuity conditions (scalar numeric)
%
% REMARKS
% - specify m as the number of derivatives to approximate PLUS ONE
% - specify k as the number of derivatives maintaining continuity, result is if class C(k-1) at best

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hNSignal' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

	if nargin < 3 || ~isscalar( m ) || ~isnumeric( m )
		error( 'invalid argument: m' );
	end

	if nargin < 4 || ~isscalar( k ) || ~isnumeric( k )
		error( 'invalid argument: k' );
	end

		% append necessary derivatives
	mtmp = size( this.data, 1 );
	for mi = 1:m-mtmp
		this.data(mtmp+mi, :) = util.deriv( this.data(end, :), this.rate, 1 );
	end

		% prepare interpolation constraints
	Xknot = cat( 1, this.data(1:m, 1:end-1), this.data(1:m, 2:end) );
	Mknot = zeros( [2*m, n+1] );

	h = 1/this.rate;

	for mi = 1:m
		if mi <= n+1
			Mknot(mi, mi) = factorial( mi-1 );
		end
		for mj = mi:n+1
			Mknot(m+mi, mj) = factorial( mj-1 )/factorial( mj-mi );
		end

		Mknot(mi, :) = Mknot(mi, :)/h^(mi-1); % temporal scaling
		Mknot(m+mi, :) = Mknot(m+mi, :)/h^(mi-1);
	end

		% prepare continuity constraints
	Acont = zeros( [k, n+1] );
	Mcont = zeros( [k, n+1] );

	for ki = 1:k
		for kj = ki:n+1
			Acont(ki, kj) = factorial( kj-1 )/factorial( kj-ki );
		end
		if ki <= n+1
			Mcont(ki, ki) = factorial( ki-1 );
		end

		Acont(ki, :) = Acont(ki, :)/h^(ki-1);
		Mcont(ki, :) = Mcont(ki, :)/h^(ki-1); % temporal scaling
	end

		% compute spline coefficients
	this.coeff = NaN( [n+1, size( this.data, 2 )-1] );

	for ti = 1:size( this.data, 2 )-1
		X = Xknot(:, ti); % interpolation constraints
		M = Mknot;

		if ti > 1 && ~any( isnan( this.coeff(:, ti-1) ) ) % continuity constraints
			for ki = 1:k
				X(end+1) = sum( Acont(ki, :).*this.coeff(:, ti-1)' );
			end
			M = cat( 1, M, Mcont );
		end

		this.coeff(:, ti) = M\X; % least squares fit
	end

end % function

