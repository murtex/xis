function xp = convert( this, x, src, dst )
% convert units
%
% xp = CONVERT( this, x, src, dst )
%
% INPUT
% this : style reference (scalar object)
% x : input (numeric)
% src : source units (char)
% dst : destination units (char)
%
% OUTPUT
% xp : converted output (numeric)

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

		% conversion
	mul = 1;

	switch src % cenversion to centimeters
		case 'millimeters'
			mul = mul/10;
		case 'points'
			mul = mul/72*2.54;
		case 'pixels'
			mul = mul/this.dpi*2.54;

		otherwise
			error( 'invalid value: src' );
	end

	switch dst % conversion from centimeters
		case 'millimeters'
			mul = mul*10;
		case 'points'
			mul = mul/2.54*72;
		case 'pixels'
			mul = mul/2.54*this.dpi;

		otherwise
			error( 'invalid value: dst' );
	end

	xp = mul * x;
	
end % function

