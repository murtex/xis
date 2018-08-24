function title( this, s, ffix )
% add figure title
%
% TITLE( this, s, ffix=false )
%
% INPUT
% this : figure reference (scalar object)
% s : title string (cell string)
% ffix : fixed size flag (scalar logical)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~iscellstr( s )
		error( 'invalid argument: s' );
	end

	if nargin < 3
		ffix = false;
	end
	if ~isscalar( ffix ) || ~islogical( ffix )
		error( 'invalid argument: ffix' );
	end

	style = hStyle.instance();
	
		% insert title
	this.fit();

	if style.fhead
		hvis = findobj( this.hfig, 'Type', 'axes', 'Visible', 'on' );
		ext = this.extent( hvis, 'raw' ); % [left, bottom, right, top]

			% create text object
		hb = this.blank( 'HitTest', 'off' );
		ht = text( 0.5, 1, s, ...
			'Units', 'normalized', ...
			'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', ...
			'FontSize', style.fsnorm, 'FontWeight', 'bold' );

			% move on top
		hbpos = get( hb, 'Position' );
		htpos = get( ht, 'Position' );
		htext = get( ht, 'Extent' );

		hbpos(1) = ext(1); % left
		hbpos(2) = 1; % bottom
		hbpos(3) = ext(3)-ext(1); % width
		hbpos(4) = htext(4)/numel( s )*(numel( s )+1/4); % height (one quarter padding)

		set( hb, 'Position', hbpos );

			% (re-)adjust figure size
		if ~ffix
			this.fit();

			set( this.hfig, 'Position', scaleheight_( get( this.hfig, 'Position' ), 1+hbpos(4) ) );
			set( this.hfig, 'PaperPosition', scaleheight_( get( this.hfig, 'PaperPosition' ), 1+hbpos(4) ) );
			set( this.hfig, 'PaperSize', scaleheight_( get( this.hfig, 'PaperSize' ), 1+hbpos(4) ) );
		end

			% final fit
		this.fit();

	end

end % function

	% local functions
function pos = scaleheight_( pos, s )
	pos(end) = s*pos(end);
end % function

