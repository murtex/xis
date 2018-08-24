function series_( x, rate )
	style = hStyle.instance();
	style.layout( 'screen', style.convert( 800, 'pixels', style.units ), style.convert( 16, 'points', style.units ) );

	fig = hFigure( 'Visible', 'on' );
	hax = fig.subplot( 1, 1, 1 );
	fig.xlabel( 'Time in s' );
	fig.ylabel( 'Amplitude' );
	fig.title( {'Time series'} );
	fig.axes( hax );

	for ai = [1:size( x, 1 )]
		xi = x(ai, :);
		ti = [0:numel( xi )-1]/rate;
		patch( 'XData', [ti, NaN], 'YData', [xi, NaN], 'FaceColor', 'none', 'EdgeColor', style.color( (ai-1)/size( x, 1 ), style.shadelo ), 'LineWidth', style.lwnorm );
	end
end

