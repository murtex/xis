function [R, theta, omega] = proto( z, rate )
% compute protophase
%
% [R, theta, omega] = PROTO( z, rate )
%
% INPUT
% z : analytic signal (vector numeric)
% rate : sampling rate (scalar numeric)
%
% OUTPUT
% R : amplitude (vector numeric)
% theta : phase (vector numeric)
% omega : angular frequency (vector numeric)

		% safeguard
	if nargin < 1 || ~isvector( z ) || ~isnumeric( z )
		error( 'invalid argument: z' );
	end

	if nargin < 2 || ~isscalar( rate ) || ~isnumeric( rate )
		error( 'invalid argument: rate' );
	end

		% compute protophase
	zr = real( z );
	zi = imag( z );

	dzr = util.deriv( zr, rate, 1 );
	dzi = util.deriv( zi, rate, 1 );

	R = sqrt( zr.^2 + zi.^2 );
	theta = atan2( zi, zr );
	omega = (zr.*dzi - zi.*dzr) ./ R.^2;

end % function

