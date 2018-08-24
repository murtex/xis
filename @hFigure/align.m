function align( this, h, mode )
% align axes
%
% ALIGN( this, h, mode )
%
% INPUT
% this : figure reference (scalar object)
% h : axis handles (graphics handle)
% mode : alignment mode (char)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~all( arrayfun( @ishghandle, h(:) ) )
		error( 'invalid argument: h' );
	end

	if nargin < 3 || ~ischar( mode )
		error( 'invalid argument: mode' );
	end

		% align axis position
	if numel( h ) < 2
		return;
	end

	ext = this.extent( h, 'raw' ); % TODO
	pos = get( h, 'Position' );

	switch mode

			% horizontal alignment
		case 'l' % left
			for i = 1:numel( h )
				pos{i}(1) = ext(1);
			end
		case 'ls' % left stretch
			for i = 1:numel( h )
				pos{i}(3) = pos{i}(3)+pos{i}(1)-ext(1);
				pos{i}(1) = ext(1);
			end
		case 'r' % right
			for i = 1:numel( h )
				pos{i}(1) = ext(3)-pos{i}(3);
			end
		case 'rs' % right stretch
			for i = 1:numel( h )
				pos{i}(3) = ext(3)-pos{i}(1);
			end
		case 'v' % left and right
			for i = 1:numel( h )
				pos{i}(1) = ext(1);
				pos{i}(3) = ext(3)-ext(1);
			end

			% vertical alignment
		case 'b' % bottom
			for i = 1:numel( h )
				pos{i}(2) = ext(2);
			end
		case 'bs' % bottom stretch
			for i = 1:numel( h )
				pos{i}(4) = pos{i}(4)+pos{i}(2)-ext(2);
				pos{i}(2) = ext(2);
			end
		case 't' % top
			for i = 1:numel( h )
				pos{i}(2) = ext(4)-pos{i}(4);
			end
		case 'ts' % top stretch
			for i = 1:numel( h )
				pos{i}(4) = ext(4)-pos{i}(2);
			end
		case 'h' % bottom and top
			for i = 1:numel( h )
				pos{i}(2) = ext(2);
				pos{i}(4) = ext(4)-ext(2);
			end

		otherwise
			error( 'invalid value: mode' );
	end

	for i = 1:numel( h )
		set( h(i), 'Position', pos{i} );
	end
	
end % function

