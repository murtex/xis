function close( this )
% lose figure
%
% CLOSE( this )
%
% INPUT
% this : figure reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

		% close figure
	close( this.hfig );

end % function

