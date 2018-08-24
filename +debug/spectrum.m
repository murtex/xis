function spectrum_( x, rate )
	style = hStyle.instance();
	style.layout( 'screen', get( 0, 'ScreenPixelsPerInch' ), '755px', '14pt' );
	style.geometry( [1, 1], [1, 1], 1.0, [NaN, NaN, NaN, NaN] );

	fig = hFigure( 'Visible', 'on' );

	hax = fig.subplot( 1, 1, 1, 'XScale', 'log' );
	fig.xlabel( 'Frequency in Hz' );
	fig.ylabel( 'Power in dB' );
	xlim( [0, rate/2] );

	fig.title( {'Power spectrum'} );

	fig.axes( hax );
	for ai = [1:size( x, 1 )]
		xi = x(ai, :); % remove nans
		xi(isnan( xi )) = [];

		xk = fft( xi )/numel( xi ); % fourier transform
		pk = 10*log( abs( xk ).^2 );

		fk = (0:numel( xi )-1)/numel( xi )*rate; % one-sided spectrum
		fk(fk >= rate/2) = fk(fk >= rate/2)-rate;
		pk(fk < 0) = [];
		fk(fk < 0) = [];

		pk(2:end) = 2*pk(2:end); % rescale

		patch( 'XData', [fk, NaN], 'YData', [pk, NaN], 'FaceColor', 'none', 'EdgeColor', style.color( (ai-1)/size( x, 1 ), style.shadelo ), 'LineWidth', style.lwnorm );
	end
end % function

