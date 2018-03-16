classdef (Sealed = true) hStyle < handle
% singleton styling

	properties

		fhead = true; % title flag
		fmono = false; % monochromatic flag
		ffull = true; % fullscreen flag

		units; % base units
		dpi; % spatial resolution
		bpp; % color resolution
		fontname; % font

		refsize_; % reference size
		refpad_; % reference padding
		refstroke_; % reference stroke
		reffont_; % reference font

		size_; % current size
		pad_; % current padding

			% aliases
		lwthinner; % line widths
		lwthin;
		lwnorm;
		lwthick;

		msnano; % marker sizes
		msmicro;
		mstiny;
		mssmall;
		msnorm;
		mslarge;

		fsnano; % font sizes
		fsmicro;
		fstiny;
		fssmall;
		fsnorm;
		fslarge;

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
		function v = get.lwthinner( this ) % line widths
			v = this.width( -2 );
		end
		function v = get.lwthin( this )
			v = this.width( -1 );
		end
		function v = get.lwnorm( this )
			v = this.width( 0 );
		end
		function v = get.lwthick( this )
			v = this.width( 1 );
		end

		function v = get.msnano( this ) % marker sizes
			v = this.width( 0 );
		end
		function v = get.msmicro( this )
			v = this.width( 1 );
		end
		function v = get.mstiny( this )
			v = this.width( 2 );
		end
		function v = get.mssmall( this )
			v = this.width( 3 );
		end
		function v = get.msnorm( this )
			v = this.width( 4 );
		end
		function v = get.mslarge( this )
			v = this.width( 5 );
		end

		function v = get.fsnano( this ) % font sizes
			v = this.reffont_*this.width( -2 )/this.width( 0 );
		end
		function v = get.fsmicro( this )
			v = this.reffont_*this.width( -1.5 )/this.width( 0 );
		end
		function v = get.fstiny( this )
			v = this.reffont_*this.width( -1 )/this.width( 0 );
		end
		function v = get.fssmall( this )
			v = this.reffont_*this.width( -0.5 )/this.width( 0 );
		end
		function v = get.fsnorm( this )
			v = this.reffont_*this.width( 0 )/this.width( 0 );
		end
		function v = get.fslarge( this )
			v = this.reffont_*this.width( 0.5 )/this.width( 0 );
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

				% dimensions
			this.layout( 'default' );

				% coloring
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

