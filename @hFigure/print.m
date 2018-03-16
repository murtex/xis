function print( this, filename, varargin )
% print figure
%
% PRINT( this, filename, ... )
%
% INPUT
% this : figure reference (scalar object)
% filename : figure filename (row char)
% ... : optional arguments

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isrow( filename ) || ~ischar( filename )
		error( 'invalid argument: filename' );
	end

	style = hStyle.instance();

		% print figure
	[~, ~, ext] = fileparts( filename );

	switch ext

			% bitmap graphics
		case '.png'
			f = this.getframe( style.dpi );
			opts = {'BitDepth', style.bpp};
			imwrite( f, filename, opts{:} );

		case '.tiff'
			f = this.getframe( style.dpi );
			opts = {'Resolution', style.dpi};
			imwrite( f, filename, opts{:} );

			% vector graphics
		case '.pdf'
			opts = {'-dpdf' sprintf( '-r%d', style.dpi )};
			print( this.hfig, filename, opts{:} );

		case '.eps'
			opts = {'-depsc2' sprintf( '-r%d', style.dpi )};
			print( this.hfig, filename, opts{:} );

			% videos (w/ optional audio)
		case '.avi'
			writeavi_( this, true, filename, varargin{:} );

		case '.mp4'
			writemp4_( this, filename, varargin{:} );

		otherwise
			error( 'invalid value: ext' );
	end

end % function

	% local functions
function writeavi_( fig, fflip, filename, varargin )

		% write avi file
	af = avifile( filename, 'compression', 'None', 'fps', fig.framerate );
	for i = 1:numel( fig.frames )
		frame = fig.frames{i};
		if fflip
			frame = flipdim( frame, 1 );
		end
		af = addframe( af, frame );
	end
	af = close( af );

		% multiplex optional audio (unix only)
	if isunix() && numel( varargin ) > 1 && numel( varargin{1} ) > 0

			% temporary wav file
		tmp1file = strcat( tempname(), '.wav' );
		util.writewav( tmp1file, varargin{1}, varargin{2} );

			% temporary multiplexing
		tmp2file = strcat( tempname(), '.avi' );

		cmd = sprintf( 'ffmpeg -y -i %s -i %s -codec copy %s', filename, tmp1file, tmp2file );
		[status, cmdout] = unix( cmd );
		if status ~= 0
			error( sprintf( 'command: ''%s'', status: %d, output: ''%s''', cmd, status, cmdout ) );
		end

			% finish
		if exist( tmp1file )
			delete( tmp1file );
		end
		if exist( tmp2file )
			movefile( tmp2file, filename );
		end

	end

end % function

function writemp4_( fig, filename, varargin )

		% temporary avi
	tmpfile = strcat( tempname(), '.avi' );
	writeavi_( fig, false, tmpfile, varargin{:} );

		% mp4 transcoding
	cmd = sprintf( 'ffmpeg -y -i %s -vcodec h264 -qp 0 -preset veryslow %s', tmpfile, filename );
	[status, cmdout] = unix( cmd );
	if status ~= 0
		error( sprintf( 'command: ''%s'', status: %d, output: ''%s''', cmd, status, cmdout ) );
	end

	if exist( tmpfile )
		delete( tmpfile );
	end

end % function

