function c = imf( x )
% intrinsic mode function
%
% c = IMF( x )
%
% INPUT
% x : data (vector numeric)
%
% OUTPUT
% c : intrinsic mode function (vector numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% compute intrinsic mode function
	len = numel( x );
	h = reshape( x, [1, len] );

	while true

			% determine peaks
		[p, ps] = util.peaks( h );
		pmin = p(ps < 0);
		pmax = p(ps > 0);

		if numel( pmin ) < 1 || numel( pmax ) < 1 % not enough
			break;
		end

		hmin = h(pmin);
		hmax = h(pmax);

			% peak reflection at boundaries
		if pmin(1) > 1
			pmin = cat( 2, 1-pmin(1), pmin );
			hmin = cat( 2, hmin(1), hmin );
		end
		if pmin(end) < len
			pmin = cat( 2, pmin, 2*len-pmin(end) );
			hmin = cat( 2, hmin, hmin(end) );
		end

		if pmax(1) > 1
			pmax = cat( 2, 1-pmax(1), pmax );
			hmax = cat( 2, hmax(1), hmax );
		end
		if pmax(end) < len
			pmax = cat( 2, pmax, 2*len-pmax(end) );
			hmax = cat( 2, hmax, hmax(end) );
		end

			% interpolated envelopes
		envmin = interp1( pmin, hmin, 1:len, 'spline' );
		envmax = interp1( pmax, hmax, 1:len, 'spline' );
		envmean = (envmin+envmax)/2;

			% sifting
		hprev = h;
		h = h - envmean;

		sd = sum( (hprev-h).^2 ./ (hprev.^2 + eps) ); % until stop criterion
		if sd < 0.2
			break;
		end

	end

	c = reshape( h, size( x ) );

end % function

