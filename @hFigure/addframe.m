function addframe( this, fdebug )
% hardcopy frame
%
% ADDFRAME( this, fdebug=false )
%
% INPUT
% this : figure reference (object scalar)
% fdebug : debugging (logical scalar)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end
	
	if nargin < 2
		fdebug = false;
	end
	if ~islogical( fdebug ) || ~isscalar( fdebug )
		error( 'invalid argument: fdebug' );
	end

	style = hStyle.instance();
	
		% add current frame
	this.frames{end+1} = this.getframe( style.dpi, fdebug );

end % function

