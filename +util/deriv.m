function d = deriv( x, rate, n )
% numerical derivation
%
% d = DERIV( x, rate, n )
%
% INPUT
% x : data (vector numeric)
% rate : sampling rate (scalar numeric)
% n : order (scalar numeric)
%
% OUTPUT
% d : n-th derivative (vector numeric)
%
% SEE
% [1] https://github.com/maroba/findiff
% [2] https://en.wikipedia.org/wiki/Finite_difference_coefficient
%
% TODO: composite order by values of 1, 2, 3
% TODO: implement matrix processing

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 2 || ~isscalar( rate ) || ~isnumeric( rate )
		error( 'invalid argument: rate' );
	end

	if nargin < 3 || ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

		% previously used kernels (up to third order, from [2])
	%k = [-1/2, 0, 1/2];
	%k = [1/12, -2/3, 0, 2/3, -1/12];
	%k = [-1/60, 3/20, -3/4, 0, 3/4, -3/20, 1/60];
	%k = [1/280, -4/105, 1/5, -4/5, 0, 4/5, -1/5, 4/105, -1/280];
	
	%k = [1, -2, 1];
	%k = [-1/12, 4/3, -5/2, 4/3, -1/12];
	%k = [1/90, -3/20, 3/2, -49/18, 3/2, -3/20, 1/90];
	%k = [-1/560, 8/315, -1/5, 8/5, -205/72, 8/5, -1/5, 8/315, -1/560];

	%k = [-1/2, 1, 0, -1, 1/2];
	%k = [1/8, -1, 13/8, 0, -13/8, 1, -1/8];
	%k = [-7/240, 3/10, -169/120, 61/30, 0, -61/30, 169/120, -3/10, 7/240];

		% central finite differences ([1] with accuracy set to 8)
	switch n
		case 1
			k = [ 3.57142857e-03, -3.80952381e-02,  2.00000000e-01, -8.00000000e-01, 4.72537324e-16,  8.00000000e-01, -2.00000000e-01,  3.80952381e-02, -3.57142857e-03];
		case 2
			k = [-1.78571429e-03,  2.53968254e-02, -2.00000000e-01,  1.60000000e+00, -2.84722222e+00,  1.60000000e+00, -2.00000000e-01,  2.53968254e-02, -1.78571429e-03];
		case 3
			k = [ 6.77910053e-03, -8.33994709e-02,  4.83035714e-01, -1.73373016e+00, 2.31805556e+00,  9.50621729e-14, -2.31805556e+00,  1.73373016e+00, -4.83035714e-01,  8.33994709e-02, -6.77910053e-03];
		case 4
			k = [-5.42328042e-03,  8.33994709e-02, -6.44047619e-01,  3.46746032e+00, -9.27222222e+00,  1.27416667e+01, -9.27222222e+00,  3.46746032e+00, -6.44047619e-01,  8.33994709e-02, -5.42328042e-03];
		case 5
			k = [ 1.14914021e-02, -1.60052910e-01,  1.03339947e+00, -3.98280423e+00, 8.39608135e+00, -8.24603175e+00,  8.34100596e-11,  8.24603175e+00, -8.39608135e+00,  3.98280423e+00, -1.03339947e+00,  1.60052910e-01, -1.14914021e-02];
		otherwise
			error( 'invalid value: n' );
	end

		% apply kernel
	%d = conv( x, k, 'same' ) * rate^n * (-1)^n;

		% apply kernel
	d = NaN( size( x ) );

	for i = 1:numel( x )
		xi = [0:numel( k )-1] - floor( numel( k )/2 ) + i;
		if ~any( xi < 1 ) && ~any( xi > numel( x ) )
			d(i) = sum( k .* x(xi) );
		end
	end

	d = d * rate^n;

end % function

