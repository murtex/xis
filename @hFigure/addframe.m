function addframe( this )
% hardcopy frame
%
% ADDFRAME( this )
%
% INPUT
% this : figure reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	style = hStyle.instance();
	
		% add current frame
	this.frames{end+1} = this.getframe( style.dpi );

end % function

