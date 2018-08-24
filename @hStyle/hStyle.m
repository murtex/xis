classdef (Sealed = true) hStyle < handle
% singleton styling

	properties

		fhead = true; % title flag
		fmono = false; % monochromatic flag
		ffull = false; % fullscreen flag
		fmenu = true; % toolbar flag
		funits = true; % units flags

		units = 'points'; % base units
		mag = sqrt( 2 ); % stroke magnification base
		dpi = 600; % spatial resolution
		bpp = 8; % color depth

		fontname = 'liberation sans'; % font
		fontmag = 1.2; % font magnification base

		refwidth; % reference width
		refstroke; % reference stroke
		reffont; % reference font

		size; % current size
		pad; % current padding

			% aliases
		lwthinnest; % line widths
		lwthinner;
		lwthin;
		lwnorm;
		lwthick;
		lwthicker;
		lwthickest;

		mssmallest; % marker sizes
		mssmaller;
		mssmall;
		msnorm;
		mslarge;
		mslarger;
		mslargest;

		fssmallest; % font sizes
		fssmaller;
		fssmall;
		fsnorm;
		fslarge;
		fslarger;
		fslargest;

			% coloring
		refp;
		umax;
		vmax;

		shadelo;
		shademed;
		shadehi;

		background;

	end % properties

	methods
		function v = get.lwthinnest( this ) % line widths
			v = this.scale( this.refstroke, this.mag, -3 );
		end
		function v = get.lwthinner( this )
			v = this.scale( this.refstroke, this.mag, -2 );
		end
		function v = get.lwthin( this )
			v = this.scale( this.refstroke, this.mag, -1 );
		end
		function v = get.lwnorm( this )
			v = this.scale( this.refstroke, this.mag, 0 );
		end
		function v = get.lwthick( this )
			v = this.scale( this.refstroke, this.mag, 1 );
		end
		function v = get.lwthicker( this )
			v = this.scale( this.refstroke, this.mag, 2 );
		end
		function v = get.lwthickest( this )
			v = this.scale( this.refstroke, this.mag, 3 );
		end

		function v = get.mssmallest( this ) % marker size
			v = this.scale( this.refstroke, this.mag, 0 );
		end
		function v = get.mssmaller( this )
			v = this.scale( this.refstroke, this.mag, 1 );
		end
		function v = get.mssmall( this )
			v = this.scale( this.refstroke, this.mag, 2 );
		end
		function v = get.msnorm( this )
			v = this.scale( this.refstroke, this.mag, 3 );
		end
		function v = get.mslarge( this )
			v = this.scale( this.refstroke, this.mag, 4 );
		end
		function v = get.mslarger( this )
			v = this.scale( this.refstroke, this.mag, 5 );
		end
		function v = get.mslargest( this )
			v = this.scale( this.refstroke, this.mag, 6 );
		end

		function v = get.fssmallest( this )
			v = this.scale( this.reffont, this.fontmag, -3 );
		end
		function v = get.fssmaller( this )
			v = this.scale( this.reffont, this.fontmag, -2 );
		end
		function v = get.fssmall( this )
			v = this.scale( this.reffont, this.fontmag, -1 );
		end
		function v = get.fsnorm( this )
			v = this.scale( this.reffont, this.fontmag, 0 );
		end
		function v = get.fslarge( this )
			v = this.scale( this.reffont, this.fontmag, 1 );
		end
		function v = get.fslarger( this )
			v = this.scale( this.reffont, this.fontmag, 2 );
		end
		function v = get.fslargest( this )
			v = this.scale( this.reffont, this.fontmag, 3 );
		end
	end % aliases

	methods ( Static = true )

		that = instance(); % class singleton

	end % static methods

	methods ( Access = private )

		function this = hStyle()
		% class constructor
		%
		% this = HSTYLE()
		%
		% OUTPUT
		% this : style reference (scalar object)

			this.units = 'points';
			this.gencols();
			this.background = this.color( NaN, this.shadehi );

		end

		function delete( this )
		% class destructor
		%
		% DELETE( this )
		%
		% INPUT
		% this : style reference (scalar object)

			% nop

		end

	end % private methods

end % classdef

