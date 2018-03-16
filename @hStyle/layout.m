function layout( this, theme )
% layout theme
%
% LAYOUT( this, theme )
%
% INPUT
% this : style reference (scalar object)
% theme : source units (char)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~ischar( theme )
		error( 'invalid argument: theme' );
	end

		% set theme
	this.units = 'points';
	this.dpi = 320;
	this.bpp = 16;
	this.fontname = 'liberation sans';

	switch theme
		case 'default'
			this.refsize_ = this.convert( [210, 148], 'millimeters', this.units ); % a5paper landscape
			this.refpad_ = 0.75;
			this.refstroke_ = this.convert( 0.25, 'millimeters', this.units ); % 0.25mm stroke
			this.reffont_ = this.convert( 3.0, 'millimeters', this.units ); % 3mm font

		%case 'paper'
			%normwidth = this.convert( 0.35, 'millimeters', this.units );
			%fontbase = this.convert( 4.0, 'millimeters', this.units );
			%size = this.convert( [210, 130], 'millimeters', this.units );

		%case 'a0poster'
			%floatwidth = 0.95;
			%this.dpi = 600;
			%normwidth = this.convert( 0.35/floatwidth, 'millimeters', this.units );
			%fontbase = this.convert( 4.0/floatwidth, 'millimeters', this.units );
			%size = this.convert( [297, 210], 'millimeters', this.units );
			
		%case 'animation'
			%normwidth = this.convert( 1.5, 'pixels', this.units );
			%fontbase = this.convert( 14, 'pixels', this.units );
			%size = this.convert( [640, 480], 'pixels', this.units );

		otherwise
			error( 'invalid value: theme' );
	end
	
end % function

