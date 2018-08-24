function [c, p] = corrcomp( x1, y1, x2, y2, param )
% correlation comparison parameters
%
% [c, p] = CORRCOMP( x1, y1, x2, y2, param )
%
% INPUT
% x1 : first predictor (numeric)
% y1 : first response (numeric)
% x2 : second predictor (numeric)
% y2 : second response (numeric)
% param : comparison parameter [see code below] (scalar numeric)
%
% OUTPUT
% c : correlation coefficient difference (scalar numeric)
% p : p-value (scalar numeric)
%
% REFERENCES
% [1] Cohen (1983), Comparing linear regression coefficients across subsamples

		% safeguard
	if nargin < 1 || ~isnumeric( x1 )
		error( 'invalid argument: x1' );
	end

	if nargin < 2 || ~isnumeric( y1 ) || ~isequal( size( y1 ), size( x1 ) )
		error( 'invalid argument: y1' );
	end

	if nargin < 3 || ~isnumeric( x2 )
		error( 'invalid argument: x2' );
	end

	if nargin < 4 || ~isnumeric( y2 ) || ~isequal( size( y2 ), size( x2 ) )
		error( 'invalid argument: y2' );
	end

	if nargin < 5 || ~isscalar( param ) || ~isnumeric( param )
		error( 'invalid argument: param' );
	end

		% compute difference
	c = NaN;
	p = NaN;

	if numel( x1 ) < 2 || numel( x2 ) < 2
		return;
	end

	switch param
		case 0 % intercept difference
			error( 'TODO!' );

		case 1 % slope difference
			p1 = polyfit( x1, y1, 1 );
			b1 = p1(1);
			s1h2 = sum( (y1-polyval( p1, x1 )).^2 )/(numel( x1 )-2);
			c1 = 1/sum( (x1-mean( x1 )).^2 );

			p2 = polyfit( x2, y2, 1 );
			b2 = p2(1);
			s2h2 = sum( (y2-polyval( p2, x2 )).^2 )/(numel( x2 )-2);
			c2 = 1/sum( (x2-mean( x2 )).^2 );

			sh2 = ((numel( x1 )-2)*s1h2 + (numel( x2 )-2)*s2h2)/(numel( x1 )+numel( x2 )-4);

			%c = abs( b1-b2 )/sqrt( c1*s1h2+c2*s2h2 ); % ~N( 0, 1 )
			%c = abs( b1-b2 )/(sqrt( sh2 )*sqrt( c1+c2 )); % ~t( n1+n2-4 )

			c = (b1-b2)^2/(sh2*(c1+c2)); % ~F( 1, n1+n2-4 )
			%p = 1-fcdf( 1/c, numel( x1 )+numel( x2 )-4, 1 );
			%p = 1-fcdf( c, 1, numel( x1 )+numel( x2 )-4 );

		case 2 % pearson difference
			rz1 = atanh( util.corrcoeff( x1, y1, 2 ) );
			rz2 = atanh( util.corrcoeff( x2, y2, 2 ) );

			c = abs( rz1-rz2 )/sqrt( 1/(numel( x1 )-3)+1/(numel( x2 )-3) ); % ~N( 0, 1 )

		case 3 % q-q pearson difference
			rz1 = atanh( util.corrcoeff( x1, y1, 4 ) );
			rz2 = atanh( util.corrcoeff( x2, y2, 4 ) );

			c = abs( rz1-rz2 )/sqrt( 1/(numel( x1 )-3)+1/(numel( x2 )-3) ); % ~N( 0, 1 )

		otherwise
			error( 'invalid value: param' );
	end

end % function

