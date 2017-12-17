function done( this )
% quit logging
%
% DONE( this )
%
% INPUT
% this : logger reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hLogger' )
		error( 'invalid argument: this' );
	end

		% destruct itself
	delete( this );

end % function

