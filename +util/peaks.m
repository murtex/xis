function [p, ps, pv] = peak( x )
% peaks
% 
% [p, ps, pv] = PEAK( x )
%
% INPUT
% x : data (vector numeric)
%
% OUTPUT
% p : peak indices (row numeric)
% ps : peak signs (row numeric)
% pv : peak values (row numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% detect peaks
	[zc, zcs] = util.zcross( util.deriv( x, 1, 1 ) );

	ps = -zcs;
	p = NaN( size( ps ) );
	pv = NaN( size( ps ) );

	for i = 1:numel( zc )
		ti = zc(i);
		if abs( x(ti) ) < abs( x(ti+1) )
			ti = ti+1;
		end

		p(i) = ti;
		pv(i) = x(ti);
	end

end % function

