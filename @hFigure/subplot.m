function h = subplot( this, m, n, p, varargin )
% create tiled axis
%
% h = SUBPLOT( this, m, n, p, ... )
%
% INPUT
% this : figure reference (scalar object)
% m : number of grid rows (scalar numeric)
% n : number of grid columns (scalar numeric)
% p : grid position (vector numeric)
%
% OUTPUT
% h : axis handle (scalar TODO)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( m ) || ~isnumeric( m )
		error( 'invalid argument: m' );
	end

	if nargin < 3 || ~isscalar( n ) || ~isnumeric( n )
		error( 'invalid argument: n' );
	end

	if nargin < 4 || ~isvector( p ) || numel( p ) > 2 || ~isnumeric( p )
		error( 'invalid argument: p' );
	end

	style = hStyle.instance();

		% prepare position
	function cp = cellpos( m, n, p )
		col = mod( p-1, n );
		row = m-1 - floor( (p-1)/n );
		cp = [col/n, row/m, (col+1)/n, (row+1)/m];
	end

	pp(1, :) = cellpos( m, n, p(1) );
	if numel( p ) > 1
		pp(2, :) = cellpos( m, n, p(end) );
	end

	ppx = min( pp(:, 1) );
	ppy = min( pp(:, 2) );
	ppw = max( pp(:, 3) ) - ppx;
	pph = max( pp(:, 4) ) - ppy;

	pos = [ppx, ppy, ppw, pph];

		% apply default padding
	switch numel( style.padding )
		case 1
			padding = repmat( style.padding, [1, 4] );
		case 2
			padding = repmat( reshape( style.padding(:), [1, 2] ), [1, 2] );
		case 4
			padding = style.padding;
		otherwise
			error( 'invalid value: padding' );
	end

	tmp = axes( 'Units', 'normalized' );
	inset = padding .* get( tmp, 'LooseInset' );
	delete( tmp );

	tmp = axes( 'Units', 'normalized', 'LooseInset', inset );
	defpos = get( tmp, 'Position' );
	delete( tmp );

	%q = pos(3)/pos(4);
	%if q > 1 % horizontal
		%padleft = defpos(1) / q;
		%padright = (1-defpos(1)-defpos(3)) / q;
		%defpos(1) = padleft;
		%defpos(3) = 1-padleft-padright;
	%else % vertical
		%padbottom = defpos(2) * q;
		%padtop = (1-defpos(2)-defpos(4)) * q;
		%defpos(2) = padbottom;
		%defpos(4) = 1-padbottom-padtop;
	%end

	pos(1) = pos(1)+defpos(1)*pos(3);
	pos(3) = defpos(3)*pos(3);
	pos(2) = pos(2)+defpos(2)*pos(4);
	pos(4) = defpos(4)*pos(4);

		% create axis
	h = axes( ...
		'Units', 'normalized', ...
		'FontSize', style.fssmall, ...
		'Position', pos, ...
				'defaultLineLineSmoothing', 'on', ...
		'LooseInset', [0, 0, 0, 0], ...
		varargin{:} );

end % function

