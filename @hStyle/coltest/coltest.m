function coltest( cmodel, n, m )
% color design test
%
% COLTEST( cmodel, n, m )
%
% INPUT
% cmodel : color space [yuv{601, 709, 2020}, ycbcr{601, 709, 2020}, ycocg] (char)
% n : number of shades (scalar numeric)
% m : number of colors (scalar numeric)

		% safeguard
	if nargin > 0 && iscellstr( cmodel )
		for mi = 1:numel( cmodel )
			coltest( cmodel{mi}, n, m );
		end

		return;
	end

	if nargin < 1 || ~ischar( cmodel )
		error( 'invalid argument: cmodel' );
	end

	if nargin < 2 || ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

	if nargin < 3 || ~isscalar( m ) || ~isnumeric( m )
		error( 'invalid argument: m' );
	end

		% initialize framework
	addpath( '~/projects/xis/' );

	style = hStyle.instance();
	style.background = [1, 1, 1];

		% set reference colors
	rrgb = [...
		[33, 26, 26]; ...
		[225, 103, 52]; ...
		[227, 215, 191]] / 255; % entr tool

	rrgb = [...
		[0, 48, 94]; ...
		[129, 139, 172]; ...
		[193, 211, 224]] / 255; % uni potsdam

	nrefs = size( rrgb, 1 );

	switch cmodel
		case 'yuv601'
			yuvfun = @( src, finv ) rgb2yuv_( src, finv, '601' );
		case 'yuv709'
			yuvfun = @( src, finv ) rgb2yuv_( src, finv, '709' );
		case 'yuv2020'
			yuvfun = @( src, finv ) rgb2yuv_( src, finv, '2020' );
		case 'ycbcr601'
			yuvfun = @( src, finv ) rgb2ycbcr_( src, finv, '601' );
		case 'ycbcr709'
			yuvfun = @( src, finv ) rgb2ycbcr_( src, finv, '709' );
		case 'ycbcr2020'
			yuvfun = @( src, finv ) rgb2ycbcr_( src, finv, '2020' );
		case 'ycocg'
			yuvfun = @rgb2ycocg_;
		otherwise
			error( 'invalid value: cmodel' );
	end

	[ryuv, umax, vmax] = yuvfun( rrgb, false );
	rshade = ryuv(:, 1);

		% fit reference colors
	%k = nrefs-1;
	k = 1;

	p(:, 1) = polyfit( rshade, ryuv(:, 1), k );
	p(:, 2) = polyfit( rshade, ryuv(:, 2), k );
	p(:, 3) = polyfit( rshade, ryuv(:, 3), k );

	fshade = linspace( 0, 1, n );
	fyuv(:, 1) = polyval( p(:, 1), fshade );
	fyuv(:, 2) = polyval( p(:, 2), fshade );
	fyuv(:, 3) = polyval( p(:, 3), fshade );

	frgb = yuvfun( fyuv, true );

		% extrapolate colors
	for mi = 1:m
		alpha = 2*pi*(mi-1)/m;

		for ni = 1:n
			tmp(1) = polyval( p(:, 1), fshade(ni) );
			tmp(2) = polyval( p(:, 2), fshade(ni) );
			tmp(3) = polyval( p(:, 3), fshade(ni) );

			cyuv(1) = tmp(1);
			cyuv(2) = sum( [cos( alpha ), -sin( alpha )] .* [tmp(2)/umax, tmp(3)/vmax] )*umax;
			cyuv(3) = sum( [sin( alpha ), cos( alpha )] .* [tmp(2)/umax, tmp(3)/vmax] )*vmax;

			crgb{mi}(ni, :) = yuvfun( cyuv, true );
			chsv{mi}(ni, :) = rgb2hsv_( crgb{mi}(ni, :) );
			cluma{mi}(ni) = cyuv(1);
		end

		for ci = 1:nrefs
			tmp(1) = polyval( p(:, 1), rshade(ci) );
			tmp(2) = polyval( p(:, 2), rshade(ci) );
			tmp(3) = polyval( p(:, 3), rshade(ci) );

			cryuv(1) = tmp(1);
			cryuv(2) = sum( [cos( alpha ), -sin( alpha )] .* [tmp(2)/umax, tmp(3)/vmax] )*umax;
			cryuv(3) = sum( [sin( alpha ), cos( alpha )] .* [tmp(2)/umax, tmp(3)/vmax] )*vmax;

			crrgb{mi}(ci, :) = yuvfun( cryuv, true );
			crhsv{mi}(ci, :) = rgb2hsv_( crrgb{mi}(ci, :) );
			crluma{mi}(ci) = cryuv(1);
		end
	end

		% prepare figure
	fig = hFigure();

	hrgb = fig.subplot( m+1, 3, 3*m+1 );
	xlim( [0, 1] );
	ylim( [0, 1] );
	fig.xlabel( 'shade' );
	fig.ylabel( 'rgb' );

	hyuv = fig.subplot( m+1, 3, 3*m+2 );
	xlim( [0, 1] );
	ylim( [0, 1] );
	fig.xlabel( 'shade' );
	fig.ylabel( cmodel );

	hluma = fig.subplot( m+1, 3, 3*m+3, 'YAxisLocation', 'right' );
	xlim( [0, 1] );
	ylim( [0, 1] );
	fig.xlabel( 'shade' );
	fig.ylabel( 'luma' );

	htest = fig.subplot( m+1, 3, [1, 3*m-1], 'Visible', 'off', 'YDir', 'reverse' );
	xlim( [1-1/2, n+1/2] );
	ylim( [1-0.4, m+0.4] );

	for mi = 1:m
		hhsv(mi) = fig.subplot( m+1, 3, 3*mi, 'XTickLabel', {}, 'YAxisLocation', 'right' );
		xlim( [0, 1] );
		ylim( [0, 1] );
		fig.ylabel( 'hsv' );
	end

	fig.align( [hrgb, htest], 'ls' ); % alignment
	fig.align( [hyuv, htest], 'rs' );
	fig.align( [hhsv, hluma], 'v' );
	fig.align( [htest, hhsv(1)], 'ts' );
	fig.align( [htest, hhsv(end)], 'bs' );

	fig.fit();

		% prepare styling
	col0 = [0.5, 0.5, 0.5];
	col1 = [0.5, 0, 0];
	col2 = [0, 0.5, 0];
	col3 = [0, 0, 0.5];

	rs0 = {'FaceColor', 'none', 'EdgeColor', 'none', 'LineStyle', 'none', 'LineWidth', style.lwthin, 'Marker', 'o', 'MarkerEdgeColor', col0, 'MarkerFaceColor', 'none', 'MarkerSize', style.mslarge};
	rs1 = {'FaceColor', 'none', 'EdgeColor', 'none', 'LineStyle', 'none', 'LineWidth', style.lwthin, 'Marker', 'o', 'MarkerEdgeColor', col1, 'MarkerFaceColor', 'none', 'MarkerSize', style.mslarge};
	rs2 = {'FaceColor', 'none', 'EdgeColor', 'none', 'LineStyle', 'none', 'LineWidth', style.lwthin, 'Marker', 'o', 'MarkerEdgeColor', col2, 'MarkerFaceColor', 'none', 'MarkerSize', style.mslarge};
	rs3 = {'FaceColor', 'none', 'EdgeColor', 'none', 'LineStyle', 'none', 'LineWidth', style.lwthin, 'Marker', 'o', 'MarkerEdgeColor', col3, 'MarkerFaceColor', 'none', 'MarkerSize', style.mslarge};

	cs0 = {'FaceColor', 'none', 'EdgeColor', 'flat', 'LineWidth', style.lwthin};
	cs1 = {'FaceColor', 'none', 'EdgeColor', col1, 'LineWidth', style.lwthin};
	cs2 = {'FaceColor', 'none', 'EdgeColor', col2, 'LineWidth', style.lwthin};
	cs3 = {'FaceColor', 'none', 'EdgeColor', col3, 'LineWidth', style.lwthin};

	ps = {'FaceColor', 'flat', 'EdgeColor', 'flat', 'LineWidth', style.lwthin};

		% plot data
	fig.axes( hrgb );
	patch( 'XData', rshade, 'YData', rrgb(:, 1), rs1{:} );
	patch( 'XData', rshade, 'YData', rrgb(:, 2), rs2{:} );
	patch( 'XData', rshade, 'YData', rrgb(:, 3), rs3{:} );
	patch( 'XData', [fshade, NaN], 'YData', [frgb(:, 1); NaN], cs1{:} );
	patch( 'XData', [fshade, NaN], 'YData', [frgb(:, 2); NaN], cs2{:} );
	patch( 'XData', [fshade, NaN], 'YData', [frgb(:, 3); NaN], cs3{:} );

	fig.axes( hyuv );
	patch( 'XData', rshade, 'YData', ryuv(:, 1), rs1{:} );
	patch( 'XData', rshade, 'YData', ryuv(:, 2)/umax/2+0.5, rs2{:} );
	patch( 'XData', rshade, 'YData', ryuv(:, 3)/vmax/2+0.5, rs3{:} );
	patch( 'XData', [fshade, NaN], 'YData', [fyuv(:, 1); NaN], cs1{:} );
	patch( 'XData', [fshade, NaN], 'YData', [fyuv(:, 2)/umax/2+0.5; NaN], cs2{:} );
	patch( 'XData', [fshade, NaN], 'YData', [fyuv(:, 3)/vmax/2+0.5; NaN], cs3{:} );

	fig.axes( hluma );
	for mi = 1:m
		x = [fshade, NaN];
		y = [cluma{mi}, NaN];
		c = repmat( crgb{mi}(1, :), [numel( x ), 1] );
		patch( 'XData', x, 'YData', y, 'FaceVertexCData', c, cs0{:} );
	end

	fig.axes( htest );
	for mi = 1:m
		for ni = 1:n % gradient
			x = [ni-1/2, ni-1/2, ni+1/2, ni+1/2];
			y = [mi+0.1, mi+0.4, mi+0.4, mi+0.1];
			c = repmat( crgb{mi}(ni, :), [4, 1] );
			patch( 'XData', x, 'YData', y, 'FaceVertexCData', c, ps{:} );
		end

		for ci = 1:nrefs % references
			x = [1/2+(ci-1)*n/nrefs, 1/2+(ci-1)*n/nrefs, 1/2+ci*n/nrefs, 1/2+ci*n/nrefs];
			y = [mi-0.4, mi+0.0, mi+0.0, mi-0.4];
			c = repmat( crrgb{mi}(ci, :), [4, 1] );
			patch( 'XData', x, 'YData', y, 'FaceVertexCData', c, ps{:} );
		end

		x = [1/2, 1/2, 1/2+n/(2*nrefs), 1/2+n/(2*nrefs)]; % darkest/brightest
		y = [mi-0.4, mi+0.0, mi+0.0, mi-0.4];
		c = repmat( crgb{mi}(1, :), [4, 1] );
		patch( 'XData', x, 'YData', y, 'FaceVertexCData', c, ps{:} );

		x = [1/2+(nrefs-1/2)*n/nrefs, 1/2+(nrefs-1/2)*n/nrefs, 1/2+n, 1/2+n];
		y = [mi-0.4, mi+0.0, mi+0.0, mi-0.4];
		c = repmat( crgb{mi}(end, :), [4, 1] );
		patch( 'XData', x, 'YData', y, 'FaceVertexCData', c, ps{:} );
	end

	for mi = 1:m
		fig.axes( hhsv(mi) );
		patch( 'XData', [fshade, NaN], 'YData', [chsv{mi}(:, 1); NaN], cs1{:} );
		patch( 'XData', [fshade, NaN], 'YData', [chsv{mi}(:, 2); NaN], cs2{:} );
		patch( 'XData', [fshade, NaN], 'YData', [chsv{mi}(:, 3); NaN], cs3{:} );
	end

		% print figure
	fig.print( sprintf( 'coltest-%s.png', cmodel ) );

end % function

	% local functions
function hsv = rgb2hsv_( rgb )
	rgb(rgb < 0) = 0;
	rgb(rgb > 1) = 1;
	hsv = rgb2hsv( rgb );
end % function

function [wr, wb] = bt_( bt )
	switch bt
		case '601'
			wr = 0.299;
			wb = 0.114;
		case '709'
			wr = 0.2126;
			wb = 0.0722;
		case '2020'
			wr = 0.2627;
			wb = 0.0593;
		otherwise
			error( 'invalid value: bt' );
	end
end

function [dst, umax, vmax] = rgb2yuv_( src, finv, bt )
	[wr, wb] = bt_( bt );
	wg = 1-wr-wb;

	umax = 0.436;
	vmax = 0.615;

	if finv % yuv -> rgb
		for ci = 1:size( src, 1 )
			y = src(ci, 1);
			u = src(ci, 2);
			v = src(ci, 3);

			dst(ci, 1) = y+v*(1-wr)/vmax;
			dst(ci, 2) = y-u*wb*(1-wb)/(umax*wg)-v*wr*(1-wr)/(vmax*wg);
			dst(ci, 3) = y+u*(1-wb)/umax;
		end

	else % rgb -> yuv
		for ci = 1:size( src, 1 )
			r = src(ci, 1);
			g = src(ci, 2);
			b = src(ci, 3);

			dst(ci, 1) = wr*r+wg*g+wb*b;
			y = dst(ci, 1);
			dst(ci, 2) = umax*(b-y)/(1-wb);
			dst(ci, 3) = vmax*(r-y)/(1-wr);
		end
	end
end % function

function [dst, umax, vmax] = rgb2ycbcr_( src, finv, bt )
	[kr, kb] = bt_( bt );
	kg = 1-kr-kb;

	umax = 1/2;
	vmax = 1/2;

	if finv % yuv -> rgb
		for ci = 1:size( src, 1 )
			y = src(ci, 1);
			u = src(ci, 2);
			v = src(ci, 3);

			dst(ci, 1) = y+v*(1-kr)/vmax;
			dst(ci, 2) = y-u*kb*(1-kb)/(umax*kg)-v*kr*(1-kr)/(vmax*kg);
			dst(ci, 3) = y+u*(1-kb)/umax;
		end

	else % rgb -> yuv
		for ci = 1:size( src, 1 )
			r = src(ci, 1);
			g = src(ci, 2);
			b = src(ci, 3);

			dst(ci, 1) = kr*r+kg*g+kb*b;
			y = dst(ci, 1);
			dst(ci, 2) = umax*(b-y)/(1-kb);
			dst(ci, 3) = vmax*(r-y)/(1-kr);
		end
	end
end % function

function [dst, umax, vmax] = rgb2ycocg_( src, finv )
	umax = 1/2;
	vmax = 1/2;

	if finv % ycocg -> rgb
		for ci = 1:size( src, 1 )
			%dst(ci, 1) = sum( [1, -1, 1] .* src(ci, :) );
			%dst(ci, 2) = sum( [1, 1, 0] .* src(ci, :) );
			%dst(ci, 3) = sum( [1, -1, -1] .* src(ci, :) );
			dst(ci, 1) = sum( [1, 1, -1] .* src(ci, :) );
			dst(ci, 2) = sum( [1, 0, 1] .* src(ci, :) );
			dst(ci, 3) = sum( [1, -1, -1] .* src(ci, :) );
		end
	else % rgb -> ycocg
		for ci = 1:size( src, 1 )
			%dst(ci, 1) = sum( [1/4, 1/2, 1/4] .* src(ci, :) );
			%dst(ci, 2) = sum( [-1/4, 1/2, -1/4] .* src(ci, :) );
			%dst(ci, 3) = sum( [1/2, 0, -1/2] .* src(ci, :) );
			dst(ci, 1) = sum( [1/4, 1/2, 1/4] .* src(ci, :) );
			dst(ci, 2) = sum( [1/2, 0, -1/2] .* src(ci, :) );
			dst(ci, 3) = sum( [-1/4, 1/2, -1/4] .* src(ci, :) );
		end
	end
end % function

