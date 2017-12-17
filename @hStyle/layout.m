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
	this.fontname = 'liberation sans';
	this.grid = [1, 1];

	switch theme
		case 'default'
			this.normwidth = this.convert( 0.25, 'millimeters', this.units );
			this.fontbase = this.convert( 3.0, 'millimeters', this.units );
			this.size = this.convert( [210, 148], 'millimeters', this.units );
			this.padding = 0.75;

		case 'paper'
			this.normwidth = this.convert( 0.35, 'millimeters', this.units );
			this.fontbase = this.convert( 4.0, 'millimeters', this.units );
			this.size = this.convert( [210, 130], 'millimeters', this.units );
			this.padding = 0.75;

		case 'a0poster'
			floatwidth = 0.95;
			this.dpi = 600;
			this.normwidth = this.convert( 0.35/floatwidth, 'millimeters', this.units );
			this.fontbase = this.convert( 4.0/floatwidth, 'millimeters', this.units );
			this.size = this.convert( [297, 210], 'millimeters', this.units );
			this.padding = 0.75;
			
		case 'animation'
			this.normwidth = this.convert( 1.5, 'pixels', this.units );
			this.fontbase = this.convert( 14, 'pixels', this.units );
			this.size = this.convert( [640, 480], 'pixels', this.units );
			this.padding = 0;

		otherwise
			error( 'invalid value: theme' );
	end
	
end % function

