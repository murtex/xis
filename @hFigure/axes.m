function axes( this, h )
% make axis current
%
% AXES( this, h )
%
% INPUT
% this : figure reference (scalar object)
% h : axis handle (scalar TODO)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( h )
		error( 'invalid argument: h' );
	end

		% set current axis
	set( this.hfig, 'CurrentAxes', h );

end % function

