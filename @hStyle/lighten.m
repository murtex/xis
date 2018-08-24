function c = lighten( this, c, v )
% lighten/darken colors
%
% c = LIGHTEN( this, c, v )
%
% INPUT
% this : style reference (scalar object)
% c : colors (matrix numeric [index, rgb])
% v : value change (scalar numeric)
%
% OUTPUT
% c : lighten colors (matrix numeric [index, rgb])

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~ismatrix( c ) || size( c, 2 ) ~= 3 || ~isnumeric( c )
		error( 'invalid argument: c' );
	end

	if nargin < 3 || ~isscalar( v ) || ~isnumeric( v )
		error( 'invalid argument: v' );
	end
	
		% linearly adjust saturation and value
	for i = 1:size( c, 1 )
		hsv = rgb2hsv( c(i, :) );

		q = v/(1-hsv(3));
		hsv(2) = max( 0, min( 1, hsv(2)-q*hsv(2) ) );
		hsv(3) = max( 0, min( 1, hsv(3)+v ) );

		c(i, :) = hsv2rgb( hsv );
	end

end

