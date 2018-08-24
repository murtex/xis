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
	pp(1, :) = cellpos_( m, n, p(1) );
	if numel( p ) > 1
		pp(2, :) = cellpos_( m, n, p(end) );
	end

	ppx = min( pp(:, 1) );
	ppy = min( pp(:, 2) );
	ppw = max( pp(:, 3) ) - ppx;
	pph = max( pp(:, 4) ) - ppy;

	pos = [ppx, ppy, ppw, pph];

		% apply tick padding
	fsize = style.fssmaller;

	[pad(1), ~] = this.padding( style.pad(1), fsize );
	[~, pad(2)] = this.padding( style.pad(2), fsize );
	[pad(3), ~] = this.padding( style.pad(3), fsize );
	[~, pad(4)] = this.padding( style.pad(4), fsize );

	pos(1) = pos(1)+pad(1);
	pos(3) = pos(3)-pad(1)-pad(3);
	pos(2) = pos(2)+pad(2);
	pos(4) = pos(4)-pad(2)-pad(4);

		% create axis
	h = axes( ...
		'Units', 'normalized', ...
		'FontSize', fsize, ...
		'Position', pos, ...
		'defaultLineLineSmoothing', 'on', ...
		'LooseInset', [0, 0, 0, 0], ...
		varargin{:} );

		% adjust tick labels
	set( get( h, 'XAxis' ), 'FontSize', fsize );
	set( get( h, 'YAxis' ), 'FontSize', fsize );
	set( get( h, 'ZAxis' ), 'FontSize', fsize );

end % function

	% local functions
function [cp, row, col] = cellpos_( m, n, p )
	col = mod( p-1, n );
	row = m-1 - floor( (p-1)/n );
	cp = [col/n, row/m, (col+1)/n, (row+1)/m];
end

