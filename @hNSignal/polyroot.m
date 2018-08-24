function xc = polyroot( this, ch, x )
% determine offset roots
%
% xc = POLYROOT( this, ch, x )
%
% INPUT
% this : signal (scalar object)
% ch : channel (scalar numeric)
% x : offset (scalar numeric)
%
% OUTPUT
% xc : offset roots (column numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hNSignal' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( ch ) || ~isnumeric( ch )
		error( 'invalid argument: ch' );
	end

	if nargin < 3 || ~isscalar( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% determine offset roots
	xc = [];

	if isempty( this.coeff )
		return;
	end

	coeff = polyderiv_( this.coeff, ch-1 ); % differentiate coefficients
	coeff(1, :) = coeff(1, :) + x/this.rate^(ch-1);

	for ti = 1:size( this.data, 2 )-1
		if ~any( isnan( coeff(:, ti) ) ) && ~any( isinf( abs( coeff(:, ti) ) ) )

				% determine polynomial roots
			lzc = roots( flipud( coeff(:, ti) ) ); % TODO: implement own version!
			lzc(imag( lzc ) ~= 0) = [];
			lzc(lzc < 0 | lzc > 1) = [];

			xc(end+1:end+numel( lzc )) = lzc + ti;

				% check for roots at discontinuities
			if ti > 1
				y = polyval_( coeff(:, [ti-1, ti]), [1, 0] );
				if prod( y ) < 0
					xc(end+1) = ti;
				end
			end

		end
	end

	xc = sort( unique( xc ) );

end % function

