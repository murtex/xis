function [zc, zcs] = zcross( x )
% zero crossings
%
% [zc, zcs] = ZCROSS( x )
%
% INPUT
% x : data (vector numeric)
%
% OUTPUT
% zc : zero crossings indices (row numeric)
% zcs : zero crossings signs (row numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% detect zero crossings
	zc = [];
	zcs = [];

	if numel( x ) < 2
		return;
	end

	x = reshape( x, [1, numel( x )] ); % row vector
	xn = cat( 2, x(2:end), 0 ); % shifted version

	zc = find( x.*xn < 0 ); % sign changes
	zcs = -sign( x(zc) );

end % function

