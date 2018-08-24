function fit( this )
% fit axes
%
% FIT( this )
%
% INPUT
% this : figure reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

		% fit axes
	hax = findobj( this.hfig, 'Type', 'axes' );
	htx = findall( this.hfig, 'Type', 'text' );

	for ri = 1:10 % run ten times

			% fit by axes
		fit_( hax, this.extent( hax, 'inset' ) );

			% fit by text
		ext = this.extent( htx, 'extent' );

		if ext(1) > 0
			ext(1) = 0;
		end
		if ext(2) > 0
			ext(2) = 0;
		end
		if ext(3) < 1
			ext(3) = 1;
		end
		if ext(4) < 1
			ext(4) = 1;
		end

		fit_( hax, ext );

	end

end % function

	% local functions
function fit_( hax, ext )
	width = ext(3)-ext(1);
	height = ext(4)-ext(2);

	for hi = 1:numel( hax )
		pos = get( hax(hi), 'Position' );

		pos(1) = (pos(1)-ext(1))/width;
		pos(3) = pos(3)/width;
		pos(2) = (pos(2)-ext(2))/height;
		pos(4) = pos(4)/height;

		set( hax(hi), 'Position', pos );
	end
end % function

