function ext = extent( this, h, type )
% get axis extent
%
% EXTENT( this, h, type )
%
% INPUT
% this : figure reference (scalar object)
% h : axis handles (graphics handle)
% type : extent type (char)
%
% OUTPUT
% ext : axis extent (row numeric [left, bottom, right, top])

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
			for i = 1:numel( h )
				pos = get( h(i), 'OuterPosition' );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end
		case 'inset'
			for i = 1:numel( h )
				pos = get( h(i), 'Position' );
				inset = get( h(i), 'TightInset' );
				ext = [min( ext(1), pos(1)-inset(1) ), min( ext(2), pos(2)-inset(2) ), max( ext(3), pos(1)+pos(3)+inset(3) ), max( ext(4), pos(2)+pos(4)+inset(4) )];
			end
		case 'inner'
			for i = 1:numel( h )
				pos = get( h(i), 'Position' );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end
		case 'raw'
			for i = 1:numel( h )
				pos = other.plotboxpos( h(i) );
				ext = [min( ext(1), pos(1) ), min( ext(2), pos(2) ), max( ext(3), pos(1)+pos(3) ), max( ext(4), pos(2)+pos(4) )];
			end

		otherwise
			error( 'invalid value: type' );
	end

	if any( isinf( ext ) )
		ext = [0, 0, 1, 1];
	end

end % function

