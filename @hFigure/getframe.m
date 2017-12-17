function f = getframe( this, dpi )
% hardcopy figure
%
% f = GETFRAME( this, dpi )
%
% INPUT
% this : figure reference (scalar object)
% dpi : resolution (scalar numeric)
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

		% hardcopy figure
	if ~util.ishg2()
		ws = warning();
		warning( 'off', 'MATLAB:hardcopy:DeprecatedHardcopyFunction' );

		f = hardcopy( this.hfig, ...
			sprintf( '-d%s', get( this.hfig, 'Renderer' ) ), ...
			sprintf( '-r%d', round( dpi ) ) );
		
		warning( ws );
	else
		f = print( this.hfig, '-RGBImage', ...
			sprintf( '-%s', get( this.hfig, 'Renderer' ) ), ...
			sprintf( '-r%d', round( dpi ) ) );
	end

end

