function f = getframe( this, dpi, fdebug )
% hardcopy figure
%
% f = GETFRAME( this, dpi, fdebug=false )
%
% INPUT
% this : figure reference (scalar object)
% dpi : resolution (scalar numeric)
% fdebug : debugging (logical scalar)
%
% OUTPUT
% f : rgb frame (numeric)
%
% TODO: control renderer (zbuffer, painters, opengl)?!

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( dpi ) || ~isnumeric( dpi )
		error( 'invalid argument: dpi' );
	end

	if nargin < 3
		fdebug = false;
	end
	if ~islogical( fdebug ) || ~isscalar( fdebug )
		error( 'invalid argument: fdebug' );
	end

		% hardcopy figure
	if ~util.ishg2()
		ws = warning();
		warning( 'off', 'MATLAB:hardcopy:DeprecatedHardcopyFunction' );

		f = hardcopy( this.hfig, ...
			sprintf( '-d%s', get( this.hfig, 'Renderer' ) ), ...
			sprintf( '-r%d', round( dpi ) ) );
		
		warning( ws );
	else
		if fdebug % debugging
			f = getfield( getframe( this.hfig ), 'cdata' );
		else % slow but working version
			f = print( this.hfig, '-RGBImage', ...
				sprintf( '-%s', get( this.hfig, 'Renderer' ) ), ...
				sprintf( '-r%d', round( dpi ) ) );
		end
	end

end

