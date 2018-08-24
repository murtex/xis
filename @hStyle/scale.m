function val = scale( this, base, mag, scale )
% magnification-based scaling
%
% val = SCALE( this, base, mag, scale )
%
% INPUT
% this : style reference (object scalar)
% base : base value (numeric scalar)
% mag : magnification (numeric scalar)
% scale : scaling factor (numeric scalar)
%
% OUTPUT
% val : magnified value (numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( base ) || ~isscalar( base )
		error( 'invalid argument: base' );
	end

	if nargin < 3 || ~isnumeric( mag ) || ~isscalar( mag )
		error( 'invalid argument: mag' );
	end

	if nargin < 4 || ~isnumeric( scale ) || ~isscalar( scale )
		error( 'invalid argument: scale' );
	end

		% magnification-based scaling
	val = base*mag^scale;

end % function

