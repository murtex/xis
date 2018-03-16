function title( this, s )
% figure title
%
% TITLE( this, s )
%
% INPUT
% this : figure reference (scalar object)
% s : title string (TODO)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 % TODO
		error( 'invalid argument: s' );
	end

	style = hStyle.instance();
	
		% insert title
	this.fit();

	if style.fhead
		hvis = findobj( this.hfig, 'Type', 'axes', 'Visible', 'on' );
		ext = this.extent( hvis, 'raw' );

			% create text
		h = this.blank();
		ht = text( 0.5, 0.5, s, ...
			'Units', 'normalized', ...
			'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
			'FontSize', style.fsnorm, 'FontWeight', 'bold' );

			% move to top
		tpos = get( ht, 'Extent' );

		pos = get( h, 'Position' );
		pos(1) = ext(1);
		pos(2) = 1;
		pos(3) = ext(3)-ext(1);
		pos(4) = tpos(4);
		set( h, 'Position', pos );

		this.fit();
	end

end % function

