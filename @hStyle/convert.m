function x = convert( this, x, src, dst )
% convert units
%
% x = CONVERT( this, x, src, dst )
%
% INPUT
% this : style reference (scalar object)
% x : input (numeric)
% src : source units (char)
% dst : destination units (char)
%
% OUTPUT
% x : converted output (numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( x )
		error( 'invalid argument: x' );
	end
	
	if nargin < 3 || ~ischar( src )
		error( 'invalid argument: src' );
	end
	
	if nargin < 4 || ~ischar( dst )
		error( 'invalid argument: dst' );
	end

		% convert to centimeters
	switch src
		case {'mm', 'millimeters'}
			x = x/10;
		case {'pt', 'points'}
			x = x/72*2.54;
		case {'px', 'pixels'}
			x = x/this.dpi*2.54;
		case {'in', 'inches'}
			x = x*2.54;

		otherwise
			error( 'invalid value: src' );
	end

		% convert from centimeters
	switch dst % conversion from centimeters
		case {'mm', 'millimeters'}
			x = 10*x;
		case {'pt', 'points'}
			x = 72*x/2.54;
		case {'px', 'pixels'}
			x = this.dpi*x/2.54;
		case {'in', 'inches'}
			x = x/2.54;

		otherwise
			error( 'invalid value: dst' );
	end

end % function

