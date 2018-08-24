function layout( this, mode, dpi, width, fontsize )
% set current layout
%
% LAYOUT( this, mode, dpi, width, fontsize )
%
% INPUT
% mode : layout mode [screen, paper, talk] (char)
% dpi : dots per inch (numeric scalar)
% width: layout width (char)
% fontsize: font size (char)

		% safeguard
	if nargin < 1 || ~ischar( mode )
		error( 'invalid argument: mode' );
	end

	if nargin < 2 || ~isnumeric( dpi ) || ~isscalar( dpi )
		error( 'invalid argument: dpi' );
	end

	if nargin < 3 || ~ischar( width )
		error( 'invalid argument: width' );
	end

	if nargin < 4 || ~ischar( fontsize )
		error( 'invalid argument: fontsize' );
	end

		% set current layout
	switch mode
		case 'screen'
			this.dpi = dpi;
			this.refwidth = convert_( this, width );
			this.refstroke = convert_( this, '0.5mm' );
			this.reffont = convert_( this, fontsize );

		case 'paper'
			this.dpi = dpi;
			this.refwidth = convert_( this, width );
			this.refstroke = convert_( this, '0.35mm' );
			this.reffont = convert_( this, fontsize );

		case 'talk'
			error( 'TODO' );

		otherwise
			error( 'invalid value: mode' );
	end

end % function

	% local functions
function v = convert_( this, v )
	v = this.convert( str2num( v([1:end-2]) ), v([end-1:end]), this.units );
end % function

