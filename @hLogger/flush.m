function done( this )
% flush logfile
%
% FLUSH( this )
%
% INPUT
% this : logger reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hLogger' )
		error( 'invalid argument: this' );
	end

		% destruct itself
	diary( 'off' );
	pause( 1 );
	diary( this.logfile );

end % function


