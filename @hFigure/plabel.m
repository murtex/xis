function plabel( this, q, pos, s, varargin )
% panel label
%
% PLABEL( this, q, pos, s, ... )
%
% INPUT
% this : figure reference (scalar object)
% q : q-value (scalar numeric)
% pos : position string [tlbr] (TODO)
% s : label (char)
% ... : addition arguments

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( q ) || ~isnumeric( q )
		error( 'invalid argument: q' );
	end

	if nargin < 3 || ~ischar( pos )
		error( 'invalid argument: pos' );
	end

	if nargin < 4 % TODO
		error( 'invalid argument: s' );
	end

	style = hStyle.instance();

		% balance q-value
	hax = get( this.hfig, 'CurrentAxes' );

	units = get( hax, 'Units' );
	set( hax, 'Units', 'pixels' );
	ext = this.extent( hax, 'raw' );
	set( hax, 'Units', units );

	width = ext(3)-ext(1);
	height = ext(4)-ext(2);
	ratio = width/height;

	if ratio > 1
		qvert = q;
		qhorz = q/ratio;
	else
		qhorz = q;
		qvert = q*ratio;
	end

		% set position
	props = {};

	if ~isempty( strfind( pos, 'l' ) ) % horizontal alignment
		x = qhorz;
		props([end+1:end+2]) = {'HorizontalAlignment', 'left'};
	elseif ~isempty( strfind( pos, 'r' ) )
		x = 1-qhorz;
		props([end+1:end+2]) = {'HorizontalAlignment', 'right'};
	else
		x = 0.5;
		props([end+1:end+2]) = {'HorizontalAlignment', 'center'};
	end

	if ~isempty( strfind( pos, 't' ) ) % vertical alignment
		y = 1-qvert;
		props([end+1:end+2]) = {'VerticalAlignment', 'top'};
	elseif ~isempty( strfind( pos, 'b' ) )
		y = qvert;
		props([end+1:end+2]) = {'VerticalAlignment', 'bottom'};
	else
		y = 0.5;
		props([end+1:end+2]) = {'VerticalAlignment', 'middle'};
	end

		% create text
	this.axes( hax );

	h = text( x, y, s, ...
		'Units', 'normalized', ...
		'FontSize', style.fsnorm, 'FontWeight', 'bold', ...
		props{:}, varargin{:} );

end % function

