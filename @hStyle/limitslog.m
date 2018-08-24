function [xl, xc] = limits( this, x, m, c )
% data limits
%
% [xl, xc] = LIMITS( this, x )
% [xl, xc] = LIMITS( this, x, m )
% [xl, xc] = LIMITS( this, x, m, c )
%
% INPUT
% this : style reference (scalar object)
% x : data (numeric)
% m : margins ratio (vector numeric [lower, upper])
% c : limit constraints (vector numeric [lower, upper])
%
% OUTPUT
% xl : data limits (row vector [lower, upper])
% xc : data center (scalar numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 3 || isempty( m )
		m = 0;
	end
	if ~isvector( m ) || ~isnumeric( m )
		error( 'invalid argument: m' );
	end
	if numel( m ) < 2
		m = [m, m];
	end

	if nargin < 4
		c = [-Inf, Inf];
	end
	if ~isvector( c ) || numel( c ) ~= 2 || ~isnumeric( c )
		error( 'invalid argument: c' );
	end

		% logarithmic limits
	if abs( m ) > 0
		[xl, xc] = this.limits( log( x ), m, log( c ) );

		xl = exp( xl );
		xc = exp( xc );
	else
		[xl, xc] = this.limits( x, m, c );
	end

end % function

