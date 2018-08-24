function ext = extent( this, h, type )
% get axis extent
%
% EXTENT( this, h, type )
%
% INPUT
% this : figure reference (scalar object)
% h : handles (graphics handle)
% type : extent type [outer, inset, inner, raw, extent] (char)
%
% OUTPUT
% ext : axis extent (row numeric [left, bottom, right, top])
%
% REMARKS
% - type 'extent' only for text objects

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~all( arrayfun( @ishghandle, h(:) ) )
		error( 'invalid argument: h' );
	end

	if nargin < 3 || ~ischar( type )
		error( 'invalid argument: type' );
	end


		% get extent
	ext = [Inf, Inf, -Inf, -Inf];

	switch type
		case 'outer'
			for hi = 1:numel( h )
				pos = get( h(hi), 'OuterPosition' );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end

		case 'inset'
			for hi = 1:numel( h )
				pos = get( h(hi), 'Position' );
				inset = get( h(hi), 'TightInset' );
				ext = [min( ext(1), pos(1)-inset(1) ), min( ext(2), pos(2)-inset(2) ), max( ext(3), pos(1)+pos(3)+inset(3) ), max( ext(4), pos(2)+pos(4)+inset(4) )];
			end

		case 'inner'
			for hi = 1:numel( h )
				pos = get( h(hi), 'Position' );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end

		case 'raw'
			addpath( fullfile( fileparts( which( 'xis' ) ), 'other/kakearney-plotboxpos-pkg-96927f2/plotboxpos/' ) );

			for hi = 1:numel( h )
				pos = plotboxpos( h(hi) );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end

			rmpath( fullfile( fileparts( which( 'xis' ) ), 'other/kakearney-plotboxpos-pkg-96927f2/plotboxpos/' ) );

		case 'extent'
			for hi = 1:numel( h )
				tmp = get( this.hfig, 'Units' ); % figure size
				set( this.hfig, 'Units', 'points' );
				fpos = get( this.hfig, 'Position' );
				set( this.hfig, 'Units', tmp );

				ppos = this.extent( get( h(hi), 'Parent' ), 'inner' ); % parent position
				pwidth = ppos(3)-ppos(1);
				pheight = ppos(4)-ppos(2);

				tmp = get( h(hi), 'Units' ); % text position and margin
				set( h(hi), 'Units', 'normalized' );
				txpos = get( h(hi), 'Extent' );
				txmar = get( h(hi), 'Margin' );
				set( h(hi), 'Units', tmp );

				marwidth = txmar/fpos(3); % transform to figure
				marheight = txmar/fpos(4);
				pos = [ppos(1)+txpos(1)*pwidth-marwidth, ppos(2)+txpos(2)*pheight-marheight, txpos(3)*pwidth+2*marwidth, txpos(4)*pheight+2*marheight];

				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end

		otherwise
			error( 'invalid value: type' );
	end

	if any( isinf( ext ) )
		ext = [0, 0, 1, 1];
	end

end % function

