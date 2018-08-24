function [X, f] = fourier( x, rate )
% fourier transform
%
% [X, f] = FOURIER( x, rate )
%
% INPUT
% x : data (vector numeric)
% rate : sampling rate (scalar numeric)
%
% OUTPUT
% X : fourier coefficients (vector numeric)
% f : frequencies (vector numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 2 || ~isscalar( rate ) || ~isnumeric( rate )
		error( 'invalid argument: rate' );
	end

		% fourier transformation
	N = numel( x );
	ny = rate/2;

	X = reshape( fft( x )/N, size( x ) );

	f = reshape( [0:N-1]/N*rate, size( x ) );
	f(f > ny) = f(f > ny)-rate;

end % function

