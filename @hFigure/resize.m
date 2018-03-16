function resize( this, m, n )
% resize figure
%
% RESIZE( this, m, n )
%
% INPUT
% this : figure reference (scalar object)
% m : number of grid rows (scalar numeric)
% n : number of grid columns (scalar numeric)

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

	style = hStyle.instance();

		% resize figure
	width = n*style.size_(1);
	height = m*style.size_(2);

	set( this.hfig, ...
		'Units', style.units, ...
		'Position', [0, 0, width, height], ...
		'PaperUnits', style.units, ...
		'PaperPosition', [0, 0, width, height], ...
		'PaperSize', [width, height] );


end % function

