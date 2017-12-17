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
% m : margins in percent (vector numeric [lower, upper])
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

		% validate data
	x = x(:);

	x(isnan( x )) = []; % remove nans

	x(isinf( x ) & x < 0) = c(1); % clamp infinities
	x(isinf( x ) & x > 0) = c(2);

	x(isinf( abs( x ) )) = []; % handle remaining infinities
	if isempty( x )
		xl = [-Inf, Inf];
		xc = 0;
		return;
	end

		% compute limits
	xmin = min( x ); 
	xmax = max( x );
	mmin = m(1);
	mmax = m(2);

	xc = (xmin+xmax)/2;

	xl(1) = (xmin*(mmax-1)+xmax*mmin) / (mmax+mmin-1);
	xl(2) = (xmin*mmax+xmax*(mmin-1)) / (mmax+mmin-1);

		% constrain limits
	cmin = c(1);
	cmax = c(2);

	if xl(1) < cmin
		xl(1) = cmin;
		if xl(2) > cmax
			xl(2) = cmax;
		else
			xl(2) = (cmin*mmax-xmax) / (mmax-1);
		end
	elseif xl(2) > cmax
		xl(1) = (cmax*mmin-xmin) / (mmin-1);
		xl(2) = cmax;
	end

		% validate limits
	if xl(1) > xl(2)
		tmp = xl(1);
		xl(1) = xl(2);
		xl(2) = tmp;
	end

	if diff( xl ) == 0
		xl = [xl(1)-m(1), xl(2)+m(2)];
	end
	if diff( xl ) == 0
		xl = [-Inf, Inf];
	end

end % function

