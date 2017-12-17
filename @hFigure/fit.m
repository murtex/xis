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

	for k = 1:10 % TODO
		ext = this.extent( hax, 'inset' );

		for i = 1:numel( hax )
			pos = get( hax(i), 'Position' );

			pos(1) = (pos(1)-ext(1))/(ext(3)-ext(1));
			pos(3) = pos(3)/(ext(3)-ext(1));
			pos(2) = (pos(2)-ext(2))/(ext(4)-ext(2));
			pos(4) = pos(4)/(ext(4)-ext(2));

			set( hax(i), 'Position', pos );
		end
	end

end % function

