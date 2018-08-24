function label( this, x, y, s, varargin )
% label current axes
%
% LABEL( this, x, y, s, ... )
%
% INPUT
% this : figure reference (scalar object)
% x : normalized horizontal position (scalar numeric)
% y : normalized vertical position (scalar numeric)
% s : title string (TODO)
% ... : optional arguments
%
% TODO: label location?

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

	if nargin < 3 || ~isscalar( y ) || ~isnumeric( y )
		error( 'invalid argument: y' );
	end

	if nargin < 4 % TODO
		error( 'invalid argument: s' );
	end

	style = hStyle.instance();

		% create label
	h = text( x, y, s, ...
		'Units', 'normalized', ...
		'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', ...
		'FontSize', style.fsnorm, 'FontWeight', 'bold', ...
		varargin{:} );

		% adjust position
	%pos = get( h, 'Position' );
	%ext = get( h, 'Extent' );

	%pos(1) = pos(1) - (ext(1)-(1-ext(3)));
	%set( h, 'Position', pos );

end % function

