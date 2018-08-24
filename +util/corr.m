function c = corr( x, y, param )
% correlation paramaters
%
% c = CORR( x, y, param )
%
% INPUT
% x : predictor (numeric)
% y : response (numeric)
% param : correlation parameter [see code] (scalar numeric)
%
% OUTPUT
% c : correlation paramater (scalar numeric)

		% safeguard
	if nargin < 1 || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 2 || ~isnumeric( y ) || ~isequal( size( y ), size( x ) )
		error( 'invalid argument: y' );
	end

	if nargin < 3 || ~isscalar( param ) || ~isnumeric( param )
		error( 'invalid argument: param' );
	end

		% compute correlation coefficient
	c = NaN;

	if numel( x ) < 2
		return;
	end

	switch param
		case 0 % linear intercept
			p = polyfit( x, y, 1 );
			c = p(2);

		case 1 % linear slope
			p = polyfit( x, y, 1 );
			c = p(1);

		case 2 % pearson correlation
			r = corrcoef( x, y );
			c = r(1, 2)^2;

		case 3 % pearson correlation p-value
			[~, rp] = corrcoef( x, y );
			c = rp(1, 2);

		case 4 % q-q pearson correlation
			p = polyfit( x, y, 1 );
			yr = student_( y-polyval( p, x ) ); % standardized residual
			yt = norminv( ([1:numel( yr )]-1/2)/numel( yr ) ); % normal distribution
			c = util.corrcoeff( yt, yr, 2 );

		case 5 % q-q pearson correlation p-value
			p = polyfit( x, y, 1 );
			yr = student_( y-polyval( p, x ) ); % standardized residual
			yt = norminv( ([1:numel( yr )]-1/2)/numel( yr ) ); % normal distribution
			c = util.corrcoeff( yt, yr, 3 );

		otherwise
			error( 'invalid value: param' );
	end

end % function

	% local functions
function r = student_( r )
	rb = mean( r );
	r = r./sqrt( var( r )*(1-1/numel( r )-(r-rb).^2/sum( (r-rb).^2 )) );
end % function

