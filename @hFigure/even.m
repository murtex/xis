function even( this, h )
% even axes scale
%
% EVEN( this, h
%
% INPUT
% this : figure reference (scalar object)
% h : axis handles (graphics handle)
%
% TODO: z-axis!

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~all( arrayfun( @ishghandle, h(:) ) )
		error( 'invalid argument: h' );
	end

		% proceed handles
	for hi = 1:numel( h )

			% display aspect ratio
		units = get( h(hi), 'Units' );
		set( h(hi), 'Units', 'pixels' );
		ext = this.extent( h(hi), 'raw' );
		set( h(hi), 'Units', units )
		adisp = (ext(3)-ext(1))/(ext(4)-ext(2));

			% data aspect ratio
		xl = get( h(hi), 'XLim' );
		yl = get( h(hi), 'YLim' );

		adata = diff( xl )/diff( yl );
		if isnan( adata )
			continue;
		end

			% adjust axes limits
		if adata > adisp
			c = mean( yl );
			r = diff( yl )*adata/adisp;
			set( h(hi), 'YLim', [c-r/2, c+r/2] );
		else
			c = mean( xl );
			r = diff( xl )*adisp/adata;
			set( h(hi), 'XLim', [c-r/2, c+r/2] );
		end

	end

end % function

